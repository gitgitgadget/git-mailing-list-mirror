From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 08/10] ref-filter: add support for %(upstream:track,nobracket)
Date: Thu, 08 Oct 2015 21:19:13 +0200
Message-ID: <vpqtwq1kw26.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-9-git-send-email-Karthik.188@gmail.com>
	<vpqziztkw4o.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGiz-0001kN-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbbJHTT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:19:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44479 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbbJHTT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:19:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t98JJBCF020358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 21:19:11 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98JJDJG009927;
	Thu, 8 Oct 2015 21:19:13 +0200
In-Reply-To: <vpqziztkw4o.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Thu, 08 Oct 2015 21:17:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 21:19:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98JJBCF020358
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444936753.32354@hb/mAgWAWxbFrw1Ac6okoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279266>

Oops, sorry, I sent the wrong message, this one is empty. Please ignore.

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add support for %(upstream:track,nobracket) which will print the
>> tracking information without the brackets (i.e. "ahead N, behind M").
>>
>> Add test and documentation for the same.
>> ---
>>  Documentation/git-for-each-ref.txt |  6 ++++--
>>  ref-filter.c                       | 28 +++++++++++++++++++++++-----
>>  t/t6300-for-each-ref.sh            |  9 +++++++++
>>  3 files changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index c713ec0..a38cbf6 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -114,8 +114,10 @@ upstream::
>>  	`refname` above.  Additionally respects `:track` to show
>>  	"[ahead N, behind M]" and `:trackshort` to show the terse
>>  	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
>> -	or "=" (in sync).  Has no effect if the ref does not have
>> -	tracking information associated with it.
>> +	or "=" (in sync).  Append `:track,nobracket` to show tracking
>> +	information without brackets (i.e "ahead N, behind M").  Has
>> +	no effect if the ref does not have tracking information
>> +	associated with it.
>>  
>>  push::
>>  	The name of a local ref which represents the `@{push}` location
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 6a38089..6044eb0 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1112,27 +1112,45 @@ static void populate_value(struct ref_array_item *ref)
>>  			if (!strcmp(formatp, "short"))
>>  				refname = shorten_unambiguous_ref(refname,
>>  						      warn_ambiguous_refs);
>> -			else if (!strcmp(formatp, "track") &&
>> +			else if (skip_prefix(formatp, "track", &valp) &&
>> +				 strcmp(formatp, "trackshort") &&
>>  				 (starts_with(name, "upstream") ||
>>  				  starts_with(name, "push"))) {
>>  				char buf[40];
>> +				unsigned int nobracket = 0;
>> +
>> +				if (!strcmp(valp, ",nobracket"))
>> +					nobracket = 1;
>>  
>>  				if (stat_tracking_info(branch, &num_ours,
>>  						       &num_theirs, NULL)) {
>> -					v->s = "[gone]";
>> +					if (nobracket)
>> +						v->s = "gone";
>> +					else
>> +						v->s = "[gone]";
>>  					continue;
>>  				}
>>  
>>  				if (!num_ours && !num_theirs)
>>  					v->s = "";
>>  				else if (!num_ours) {
>> -					sprintf(buf, "[behind %d]", num_theirs);
>> +					if (nobracket)
>> +						sprintf(buf, "behind %d", num_theirs);
>> +					else
>> +						sprintf(buf, "[behind %d]", num_theirs);
>>  					v->s = xstrdup(buf);
>>  				} else if (!num_theirs) {
>> -					sprintf(buf, "[ahead %d]", num_ours);
>> +					if (nobracket)
>> +						sprintf(buf, "ahead %d", num_ours);
>> +					else
>> +						sprintf(buf, "[ahead %d]", num_ours);
>>  					v->s = xstrdup(buf);
>>  				} else {
>> -					sprintf(buf, "[ahead %d, behind %d]",
>> +					if (nobracket)
>> +						sprintf(buf, "ahead %d, behind %d",
>> +							num_ours, num_theirs);
>> +					else
>> +						sprintf(buf, "[ahead %d, behind %d]",
>>  						num_ours, num_theirs);
>>  					v->s = xstrdup(buf);
>>  				}
>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> index 4f620bf..7ab8bf8 100755
>> --- a/t/t6300-for-each-ref.sh
>> +++ b/t/t6300-for-each-ref.sh
>> @@ -344,6 +344,15 @@ test_expect_success 'Check upstream:track format' '
>>  '
>>  
>>  cat >expected <<EOF
>> +ahead 1
>> +EOF
>> +
>> +test_expect_success 'Check upstream:track,nobracket format' '
>> +	git for-each-ref --format="%(upstream:track,nobracket)" refs/heads >actual &&
>> +	test_cmp expected actual
>> +'
>> +
>> +cat >expected <<EOF
>>  >
>>  EOF

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
