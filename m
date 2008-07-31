From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) 5/6] gitk: Fixed automatic row selection during load.
Date: Thu, 31 Jul 2008 16:41:20 +0400
Message-ID: <bb6f213e0807310541s383c2938q91543a1c57a4d71f@mail.gmail.com>
References: <200807271017.23272.angavrilov@gmail.com>
	 <200807271020.02415.angavrilov@gmail.com>
	 <200807271020.53171.angavrilov@gmail.com>
	 <200807271021.46661.angavrilov@gmail.com>
	 <18577.41259.758690.635991@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXVP-0001va-U9
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 14:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbYGaMlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 08:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbYGaMlY
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 08:41:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7005 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbYGaMlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 08:41:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so216184nfc.21
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AJNQefKM0sEOrdwnv3FQvo5uzMUr8sKRi2SSHFdYJ7k=;
        b=Lp8pNgmIc7P0KBpKIIT+2q4DP+2lt7lFPKzAaRT/TlEV2YRygR+QPE4SZLR8ONRDDB
         scwtO0hz6l3IyhBzyO3liVNac2xYKobnCDh4reiKBscAUqSDTvJK/P7duvNQIsxXWYJf
         Q+XyVUrWpyPteUaGXITY9pY9A6DJBLuAWQHW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vG9RricwJn7KbIA7EMMqcw2SyNWXQo17zEDMCqTQtbP6YV1X80AXYDj4l89XdDdpmQ
         GHhIp50PI0067q6dzmrUPpDKWBd83BKqobq6eaWH0xmyNxtMtDnr4nPbdSzKLeDnj4eV
         XdC+zPfZrPppnUxLwajkyQfE/RzWfrO8GtSmY=
Received: by 10.103.24.11 with SMTP id b11mr3972021muj.77.1217508080468;
        Thu, 31 Jul 2008 05:41:20 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 31 Jul 2008 05:41:20 -0700 (PDT)
In-Reply-To: <18577.41259.758690.635991@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90938>

On Thu, Jul 31, 2008 at 3:25 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> - Switching views now actually preserves the selected commit.
>> - Reloading (also Edit View) preserves the currently selected commit.
>> - Initial selection does not produce weird scrolling.
>>
>> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
>
> I need a more detailed explanation of the rationale for the specific
> changes you have made in the changelog.

The rationale is that preserving the currently selected commit is more
intelligent behavior than always resetting to a preset position, and
it makes the UI feel more smooth. Also, although it is possible to
restore selection by clicking the 'back' button, it is not immediately
obvious; in fact I realized it only after reading the code.

Gitk already tried to preserve the commit in many cases, but failed
because of a conflicting change that made it select the head. Such
behavior is clearly a bug.

The Reload case is arguable, but I think that Edit View should
preserve the selection, and it uses Reload internally. It can be
resolved by adding a parameter to the function implementing Reload.

> As for the patch, it mostly looks good, but I have a few comments
> below.
>
>> +proc getcommits {selid} {
>>      global canv curview need_redisplay viewactive
>>
>>      initlayout
>>      if {[start_rev_list $curview]} {
>> +     reset_pending_select $selid
>
> Is there any significance to having the call to reset_pending_select
> after the start_rev_list call (other than not setting pending_select
> if start_rev_list fails)?  I couldn't see any.  If there is then it
> should be noted in a comment and/or the patch description.

It simply tries to preserve the original behavior.

>> @@ -503,7 +511,7 @@ proc updatecommits {} {
>>      filerun $fd [list getcommitlines $fd $i $view 1]
>>      incr viewactive($view)
>>      set viewcomplete($view) 0
>> -    set pending_select $mainheadid
>> +    reset_pending_select {}
>
> This doesn't actually change anything, right?  If so then I'd prefer
> the simple, direct assignment to calling a procedure that does the
> assignment.

I have a patch WIP that allows specifying a commit on the command line
to select instead of the head (I need it to enhance the git gui blame
UI). It makes the function somewhat more intelligent. I'll submit it
as soon as this series is sorted out.

>> @@ -4036,6 +4042,7 @@ proc layoutmore {} {
>>      }
>>      if {[info exists pending_select] &&
>>       [commitinview $pending_select $curview]} {
>> +     update
>>       selectline [rowofcommit $pending_select] 1
>
> What does that update do?  Would update idletasks be better?

That update forces Tk to recompute the widget dimensions. Otherwise
selectline sometimes gets all zeroes from yview, which makes it
compute really weird scrolling settings. Git-gui always does an update
before scrolling computations.

Alexander
