From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] merge-recursive: options to ignore whitespace
 changes
Date: Fri, 27 Aug 2010 03:24:32 -0500
Message-ID: <20100827082432.GA4800@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino>
 <20100826055147.GG9708@burratino>
 <7viq2xmipe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 10:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OouGe-0005gE-FS
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 10:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab0H0I00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 04:26:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40214 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab0H0I0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 04:26:23 -0400
Received: by ywh1 with SMTP id 1so691989ywh.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3Qc1xDrZyn7/9mHJNpS776dhDJrhwjHmkerh00CpKXw=;
        b=V+KrJp6sS0gt56YX+pgwYUJQy2SUTHixzigzXJyXNZ4JzaG9OVRKPMNljjPEJnNpwR
         LniQKBMY9mBxjiixtYCqJh3a4NjRpHO0eRr8fWWuZeArvxLECCwMCN2DBN1FSYQIY69Y
         lal48aqsZa+GSwIVClE0k8QzMDRU9bAp48p30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WPphFl5HRlzhhAElCaqssWxRY2rx7FztKrK7f6N+J83TumYUR5Gs/STGm4jUWozYnd
         2+Sszp4s1kyp78TO37EGgzNBeBGEUfAsL9d7KodQBPP70GOjcTL+plS5j0pki/4i99Ca
         8nyms3ki7sbbcnIODAZV+3hwINNsbeSMskFco=
Received: by 10.90.82.5 with SMTP id f5mr1364855agb.110.1282897582763;
        Fri, 27 Aug 2010 01:26:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm3473002ibk.19.2010.08.27.01.26.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 01:26:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viq2xmipe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154589>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> From: Justin Frankel <justin@cockos.com>
>>
>> Add support for merging with ignoring line endings (specifically
>> --ignore-space-at-eol) when using recursive merging.  This is
>> as a strategy-option, so that you can do:
>
> "This is as a strategy-option"?  s/is/& done/ perhaps?

Sure, that makes it clearer.

> Otherwise looks good to me.

Hmph, one embarrasingly sloppy bit on my part:

+       else if (!strcmp(s, "ignore-space-at-eol"))
+               o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+       else if (!strcmp(s, "ignore-space-at-eol"))
+               o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;

Here's a fixup, plus a quick test while at it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 merge-recursive.c                  |    2 -
 t/t3032-merge-recursive-options.sh |  186 ++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100755 t/t3032-merge-recursive-options.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 944ca19..9b9f97e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1521,8 +1521,6 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->xdl_opts |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(s, "ignore-space-at-eol"))
 		o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
-	else if (!strcmp(s, "ignore-space-at-eol"))
-		o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(s, "renormalize"))
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
new file mode 100755
index 0000000..2293797
--- /dev/null
+++ b/t/t3032-merge-recursive-options.sh
@@ -0,0 +1,186 @@
+#!/bin/sh
+
+test_description='merge-recursive options
+
+* [master] Clarify
+ ! [remote] Remove cruft
+--
+ + [remote] Remove cruft
+*  [master] Clarify
+*+ [remote^] Initial revision
+*   ok 1: setup
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	conflict_hunks () {
+		sed -n -e "
+			/^<<<</ b inconflict
+			b
+			: inconflict
+			p
+			/^>>>>/ b
+			n
+			b inconflict
+		" "$@"
+	} &&
+
+	cat <<-\EOF >text.txt &&
+	    Hope, he says, cherishes the soul of him who lives in
+	    justice and holiness and is the nurse of his age and the
+	    companion of his journey;--hope which is mightiest to sway
+	    the restless soul of man.
+
+	How admirable are his words!  And the great blessing of riches, I do
+	not say to every man, but to a good man, is, that he has had no
+	occasion to deceive or to defraud others, either intentionally or
+	unintentionally; and when he departs to the world below he is not in
+	any apprehension about offerings due to the gods or debts which he owes
+	to men.  Now to this peace of mind the possession of wealth greatly
+	contributes; and therefore I say, that, setting one thing against
+	another, of the many advantages which wealth has to give, to a man of
+	sense this is in my opinion the greatest.
+
+	Well said, Cephalus, I replied; but as concerning justice, what is
+	it?--to speak the truth and to pay your debts--no more than this?  And
+	even to this are there not exceptions?  Suppose that a friend when in
+	his right mind has deposited arms with me and he asks for them when he
+	is not in his right mind, ought I to give them back to him?  No one
+	would say that I ought or that I should be right in doing so, any more
+	than they would say that I ought always to speak the truth to one who
+	is in his condition.
+
+	You are quite right, he replied.
+
+	But then, I said, speaking the truth and paying your debts is not a
+	correct definition of justice.
+
+	CEPHALUS - SOCRATES - POLEMARCHUS
+
+	Quite correct, Socrates, if Simonides is to be believed, said
+	Polemarchus interposing.
+
+	I fear, said Cephalus, that I must go now, for I have to look after the
+	sacrifices, and I hand over the argument to Polemarchus and the company.
+	EOF
+	git add text.txt &&
+	test_tick &&
+	git commit -m "Initial revision" &&
+
+	git checkout -b remote &&
+	sed -e "
+			s/\.  /\. /g
+			s/[?]  /? /g
+			s/    /	/g
+			s/--/---/g
+			s/but as concerning/but as con cerning/
+			/CEPHALUS - SOCRATES - POLEMARCHUS/ d
+		" text.txt >text.txt+ &&
+	mv text.txt+ text.txt &&
+	git commit -a -m "Remove cruft" &&
+
+	git checkout master &&
+	sed -e "
+			s/\(not in his right mind\),\(.*\)/\1;\2Q/
+			s/Quite correct\(.*\)/It is too correct\1Q/
+			s/unintentionally/un intentionally/
+			/un intentionally/ s/$/Q/
+			s/Polemarchus interposing./Polemarchus, interposing.Q/
+			/justice and holiness/ s/$/Q/
+			/pay your debts/ s/$/Q/
+		" text.txt | q_to_cr >text.txt+ &&
+	mv text.txt+ text.txt &&
+	git commit -a -m "Clarify" &&
+	git show-branch --all
+'
+
+test_expect_success 'naive merge fails' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive HEAD^ -- HEAD remote &&
+	test_must_fail git update-index --refresh &&
+	grep "<<<<<<" text.txt
+'
+
+test_expect_success '--ignore-space-change makes merge succeed' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote
+'
+
+test_expect_success '--ignore-space-change: our w/s-only change wins' '
+	q_to_cr <<-\EOF >expected &&
+	    justice and holiness and is the nurse of his age and theQ
+	EOF
+
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
+	grep "justice and holiness" text.txt >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--ignore-space-change: their real change wins over w/s' '
+	cat <<-\EOF >expected &&
+	it?---to speak the truth and to pay your debts---no more than this? And
+	EOF
+
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
+	grep "pay your debts" text.txt >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--ignore-space-change: does not ignore new spaces' '
+	cat <<-\EOF >expected1 &&
+	Well said, Cephalus, I replied; but as con cerning justice, what is
+	EOF
+	q_to_cr <<-\EOF >expected2 &&
+	un intentionally; and when he departs to the world below he is not inQ
+	EOF
+
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
+	grep "Well said" text.txt >actual1 &&
+	grep "when he departs" text.txt >actual2 &&
+	test_cmp expected1 actual1 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success '--ignore-all-space drops their new spaces' '
+	cat <<-\EOF >expected &&
+	Well said, Cephalus, I replied; but as concerning justice, what is
+	EOF
+
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-all-space HEAD^ -- HEAD remote &&
+	grep "Well said" text.txt >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--ignore-all-space keeps our new spaces' '
+	q_to_cr <<-\EOF >expected &&
+	un intentionally; and when he departs to the world below he is not inQ
+	EOF
+
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-all-space HEAD^ -- HEAD remote &&
+	grep "when he departs" text.txt >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--ignore-space-at-eol' '
+	q_to_cr <<-\EOF >expected &&
+	<<<<<<< HEAD
+	is not in his right mind; ought I to give them back to him?  No oneQ
+	=======
+	is not in his right mind, ought I to give them back to him? No one
+	>>>>>>> remote
+	EOF
+
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --ignore-space-at-eol \
+						 HEAD^ -- HEAD remote &&
+	conflict_hunks text.txt >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.2.2
