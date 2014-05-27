From: Phil Hord <hordp@cisco.com>
Subject: Re: [RFC 2/3] rebase -i: Reschedule tasks that failed before the
 index was touched
Date: Tue, 27 May 2014 14:26:34 -0400
Message-ID: <5384D8DA.40005@cisco.com>
References: <533C913C.20106@cisco.com> <5383BDEA.9070908@gmail.com> <53847D7D.5050000@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org,
	phil.hord@gmail.com
X-From: git-owner@vger.kernel.org Tue May 27 20:36:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMEI-0006xv-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbaE0SgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:36:00 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:56044 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbaE0Sf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:35:59 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2014 14:35:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2978; q=dns/txt; s=iport;
  t=1401215759; x=1402425359;
  h=message-id:date:from:mime-version:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=HDBYwBe86YxQwG/haHmD35q/c2Fh9ZQpupJ08DkCCSE=;
  b=YlfBxwzQjWGNovqVh6iPUFl1FPkeN7/yn/LmUQ41sZjnCwc6o+czB4Vb
   Syei2kvD2zHLfAQwO7rNjrYro8Ln6jmeix7z9Jhop9jZe4O47BJanUq/D
   alnA2QRvQSjrZDByLVeFf6vTTZ3YPw09k4kFY9icrmBm6MpX2Ys2favWV
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgsFAFTYhFOtJA2E/2dsb2JhbABZDoJ5UsJ0AYEOFnSCJQEBAQSBCQsOCgklDwJGBgEMCAEBiD4N1TAXjh86hEABA5lzhmuMPIF4gQBc
X-IronPort-AV: E=Sophos;i="4.98,921,1392163200"; 
   d="scan'208";a="47642376"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-5.cisco.com with ESMTP; 27 May 2014 18:26:35 +0000
Received: from [64.100.104.110] (dhcp-64-100-104-110.cisco.com [64.100.104.110])
	by alln-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id s4RIQZ72007287;
	Tue, 27 May 2014 18:26:35 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53847D7D.5050000@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250183>

Hi Fabian,

Thanks for looking into this.

On 05/27/2014 07:56 AM, Michael Haggerty wrote:
>> +reschedule_last_action () {
>> +	tail -n 1 "$done" | cat - "$todo" >"$todo".new
>> +	sed -e \$d <"$done" >"$done".new
>> +	mv -f "$todo".new "$todo"
>> +	mv -f "$done".new "$done"
>> +}
>> +
>>  append_todo_help () {
>>  	git stripspace --comment-lines >>"$todo" <<\EOF
>>  
>> @@ -470,11 +480,15 @@ do_pick () {
>>  			   --no-post-rewrite -n -q -C $1 &&
>>  			pick_one -n $1 &&
>>  			git commit --allow-empty --allow-empty-message \
>> -				   --amend --no-post-rewrite -n -q -C $1 ||
>> -			die_with_patch $1 "Could not apply $1... $2"
>> +				   --amend --no-post-rewrite -n -q -C $1
> "git cherry-pick" indicates its error status specifically as 1 or some
> other value.  But here it could be that pick_one succeeds but "git
> commit" fails; in that case ret is set to the return code of "git
> commit".  So, if "git commit" fails with a retcode different than 1,
> then reschedule_last_action will be called a few lines later.  This
> seems incorrect to me.

I agree.  I was thinking that pick_one should get this new behavior
instead of do_pick, but some callers may not appreciate the new behavior
(i.e. squash/fixup), though I expect those callers have similar problems
as this commit is trying to fix.

I think adding a pick_one_with_reschedule function (to be called in both
places from do_pick) could solve the issue Michael mentioned without
breaking other pick_one callers.

I have not tested doing so, but I think it would look like this:

===================

diff --git i/git-rebase--interactive.sh w/git-rebase--interactive.sh
index fe813ba..ae5603a 100644
--- i/git-rebase--interactive.sh
+++ w/git-rebase--interactive.sh
@@ -235,6 +235,17 @@ git_sequence_editor () {
     eval "$GIT_SEQUENCE_EDITOR" '"$@"'
 }
 
+pick_one_with_reschedule () {
+    pick_one $1
+    ret=$?
+    case "$ret" in
+        0) ;;
+        1) ;;
+        *) reschedule_last_action ;;
+    esac
+    return $ret
+}
+
 pick_one () {
     ff=--ff
 
@@ -474,13 +485,13 @@ do_pick () {
         # rebase --continue.
         git commit --allow-empty --allow-empty-message --amend \
                --no-post-rewrite -n -q -C $1 &&
-            pick_one -n $1 &&
+            pick_one_with_reschedule -n $1 &&
             git commit --allow-empty --allow-empty-message \
                    --amend --no-post-rewrite -n -q -C $1 \
                    ${gpg_sign_opt:+"$gpg_sign_opt"} ||
             die_with_patch $1 "Could not apply $1... $2"
     else
-        pick_one $1 ||
+        pick_one_with_reschedule $1 ||
             die_with_patch $1 "Could not apply $1... $2"
     fi
 }

===================

I don't much like the name 'pick_one_with_reschedule', but I didn't like
my other choices, either.

I'll try to look at this and your patches more closely when I have a bit
more time.

Phil
