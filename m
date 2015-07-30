From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Thu, 30 Jul 2015 09:29:00 +0200
Message-ID: <vpqbneucddv.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
	<vpqh9oov017.fsf@anie.imag.fr>
	<CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
	<vpq3807gdp0.fsf@anie.imag.fr>
	<CAOLa=ZTHRLTbmB7iadc3z7=-pshjR0QS8R_StZb7xOyu_gJ=Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 09:29:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKiHI-0006XL-Be
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 09:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbbG3H3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 03:29:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37951 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbG3H3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 03:29:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6U7T0Ql012174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jul 2015 09:29:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6U7T0Bp029272;
	Thu, 30 Jul 2015 09:29:00 +0200
In-Reply-To: <CAOLa=ZTHRLTbmB7iadc3z7=-pshjR0QS8R_StZb7xOyu_gJ=Sw@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 30 Jul 2015 12:07:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 30 Jul 2015 09:29:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6U7T0Ql012174
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438846144.99479@kfCIptSAKGfyjZWJDKNkog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274974>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Jul 29, 2015 at 9:26 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> On Tue, Jul 28, 2015 at 7:47 PM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>>
>>>> I'm not sure what's the convention, but I think the test description
>>>> should give the expected behavior even with test_expect_failure.
>>>>
>>>> And please help the reviewers by saying what's the status wrt this test
>>>> (any plan on how to fix it?).
>>>>
>>>
>>> On the other hand I wonder if the test is even needed as, we don't
>>> really need it
>>> Cause we remove that ability of branch.c by using filter_refs().
>>
>> Please read d0f810f (refs.c: allow listing and deleting badly named
>> refs, 2014-09-03). I think the reasoning makes sense, and we should keep
>> this ability.
>>
>
> This makes sense, I didn't have a thorough look at this but it breaks
> a little in
> ref-filter.c while getting object attributes. So is it okay to mark
> this as TODO?

Solving this doesn't seem much harder than

diff --git a/ref-filter.c b/ref-filter.c
index 6c0189f..a4df287 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1117,7 +1117,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct commit *commit = NULL;
 	unsigned int kind;
 
-	if (flag & REF_BAD_NAME) {
+	if (!filter->show_bad_name_refs && (flag & REF_BAD_NAME)) {
 		  warning("ignoring ref with broken name %s", refname);
 		  return 0;
 	}
diff --git a/ref-filter.h b/ref-filter.h
index 98ebd3b..b9d2bbc 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -79,7 +79,7 @@ struct ref_filter {
 		match_as_path : 1;
 	unsigned int lines, branch_kind;
 	int abbrev, verbose;
-	int detached : 1;
+	int detached : 1, show_bad_name_refs : 1;
 };
 
 struct ref_filter_cbdata {

and setting filter->show_bad_name_refs when needed (untested). Did I
miss something?

IIRC, historicaly Git allowed some weirdly named refs which made some
commands ambiguous (e.g. a branch named after an option like '-d').
We're forbidding their creation so people shouldn't have any, but we
it's important to continue showing them in case some people have old
bad-named branches lying around.

I'd rather have the code strictly better after your contribution than
before.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
