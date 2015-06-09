From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Tue, 9 Jun 2015 20:17:09 +0200 (CEST)
Message-ID: <2139695602.323234.1433873829922.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <xmqqvbey7wzp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:16:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2O4h-0005F5-M7
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbbFISQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:16:32 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:51602 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753920AbbFISQa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 14:16:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2CFF027D9;
	Tue,  9 Jun 2015 20:16:28 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYnyZ5y92K5C; Tue,  9 Jun 2015 20:16:28 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 19E2A27B0;
	Tue,  9 Jun 2015 20:16:28 +0200 (CEST)
In-Reply-To: <xmqqvbey7wzp.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: bisect: simplify the add of new bisect terms
Thread-Index: WrNV/LJ/VRMqt83nr6xh5Avtfug1dQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271214>

Hi,

Thanks for the review,

Junio C Hamano <gitster@pobox.com> writes:

>>  /*
>> + * The terms used for this bisect session are stocked in
>> + * BISECT_TERMS: it can be bad/good or new/old.
>> + * We read them and stock them to adapt the messages
>> + * accordingly. Default is bad/good.
>> + */
>
>s/stock/store/ perhaps?  I think the idea is not to have this file
>in the default case so that absence of it would mean you would be
>looking for a transition from (older) good to (more recent) bad.

Yes it is nice but a bisect_terms file is a very useful tool for 
verifications at a little cost. For instance, if the user type this:
git bisect start 
git bisect bad HEAD
git bisect old HEAD~10

We created the bisect_terms file after the bad then the error is
directly detected when the user type git bisect old.
And I think having we should limit the impact of this good/bad
default case as we would prefer old/new.

>> +void read_bisect_terms(void)
>> +{
>> +        struct strbuf str = STRBUF_INIT;
>> +        const char *filename = git_path("BISECT_TERMS");
>> +        FILE *fp = fopen(filename, "r");
>> +
>> +        if (!fp) {
>
>We might want to see why fopen() failed here.  If it is because the
>file did not exist, great.  But otherwise?

Should we display a specific message and cancel the last command?

>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 1f16aaf..529bb43 100644
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -77,6 +77,7 @@ bisect_start() {
>>          orig_args=$(git rev-parse --sq-quote "$@")
>>          bad_seen=0
>>          eval=''
>> +        start_bad_good=0
>>          if test "z$(git rev-parse --is-bare-repository)" != zfalse
>>          then
>>                  mode=--no-checkout
>> @@ -101,6 +102,9 @@ bisect_start() {
>>                                  die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
>>                                  break
>>                          }
>> +
>> +                        start_bad_good=1
>> +
>
>It is unclear what this variable means, or what it means to have
>zero or one as its value.

This has been done by our elders and we kept because it was 
useful. We are however trying to remove it. It is in case of 
a 'git bisect start bad_rev good_rev', our function that creates
the bisect_terms is not called. Thus we need to do it manually
in the code.

>> +get_terms () {
>> +        if test -s "$GIT_DIR/BISECT_TERMS"
>> +        then
>> +                NAME_BAD="$(sed -n 1p "$GIT_DIR/BISECT_TERMS")"
>> +                NAME_GOOD="$(sed -n 2p "$GIT_DIR/BISECT_TERMS")"
>
>It is sad that we need to open the file twice.  Can't we do
>something using "read" perhaps?

The cost of it is quite low and we see directly what we meant. We didn't 
found a pretty way to read two lines with read.

>Don't we want to make sure these two names are sensible?  We do not
>want an empty-string, for example.  I suspect you do not want to
>take anything that check-ref-format does not like.
>
>Same comment applies to the C code.

Yes, for now only bad/good/old/new are allowed. But in the future
it will be necessary.

>> +bisect_voc () {
>> +        case "$1" in
>> +        bad) echo "bad" ;;
>> +        good) echo "good" ;;
>> +        esac
>> +}
>
>What is voc?
>
>What if "$1" is neither bad/good?
>
>Did you mean to translate 'bad' to $NAME_BAD and 'good' to $NAME_GOOD?

voc stands for vocabulary. 
This fonction is mainly used after to display all the builtins possibility.  It
is only called internally and if the argument is bad it returns the synonyms of
bad (bad|new in the next patch). 
