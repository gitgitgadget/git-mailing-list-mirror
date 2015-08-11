From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] pseudorefs: create and use pseudoref update and delete functions
Date: Tue, 11 Aug 2015 15:47:36 -0700
Message-ID: <xmqqbnedo31z.fsf@gitster.dls.corp.google.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
	<1438322781-21181-3-git-send-email-dturner@twopensource.com>
	<CAGZ79kZ-e-GU5FfKWDAUxQPUnyrmGjSvHGnjWn=pwpDAj37umQ@mail.gmail.com>
	<1439318789.5283.23.camel@twopensource.com>
	<xmqqh9o5o3r2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:54:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPIRT-00047G-1P
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 00:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbbHKWyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 18:54:43 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36556 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304AbbHKWym (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 18:54:42 -0400
Received: by pdco4 with SMTP id o4so33695pdc.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6FurKHrNdjlMZe9ll7AftWZ5EbbRLmANmi3s/iozDck=;
        b=hbUGgog+8oHJU8MaDEpHzHucXe84BGP3+jd/tQfZezKvwKL3KeotRD4oyKEzWUcZIc
         wKOf8ltuteqH6mNK9z6rtEO0Pr9Usf4pGu40l5HZIlcnj2dMPN9TlVCfqLuoHmemZL2r
         ow2SOEHaIasmltNdPJvEtmWh2VI4nWqbpdm6zDMawxfkDk5uWlqncLhnOTBkJjOaU/J/
         BvuqhECacRBUASSPk9OT3D8HP7mc8Fhtq/622sC+r/ubMetW3t65DMpKtC3M3JVR1wXy
         SeTA9bnlOHqXoGjSQ65WDiBVFtNj9wQAJFWUJdaADprl0C3rmYcFNMjmWBCUNClepi8z
         P4sA==
X-Received: by 10.70.49.104 with SMTP id t8mr26247010pdn.13.1439333257828;
        Tue, 11 Aug 2015 15:47:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id bu10sm3952720pac.36.2015.08.11.15.47.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:47:36 -0700 (PDT)
In-Reply-To: <xmqqh9o5o3r2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 11 Aug 2015 15:32:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275742>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> On Fri, 2015-07-31 at 16:40 -0700, Stefan Beller wrote:
>>> I am sorry for being late to the review, I looked into coverity today as Duy
>>> bugged me to fix the memory allocation stuff[1]
>>
>> Thanks. Junio, can you pleas substitute the attached patch instead?
>
> No.  The topic is already in 'next', no?

Yes, the topic is already in 'next'.  A follow-up fix would be good.

The patch didn't apply cleanly on top of 74ec19d^ to replace 74ec19d
anyway, so I was about to discard it, but after conflict resolution,
the interdiff turns out just these two hunks.

-- >8 --
Subject: pseudoref: check return values from read_ref()
From: David Turner <dturner@twopensource.com>
Date: Wed, 15 Jul 2015 18:05:28 -0400

These codepaths attempt to compare the "expected" current value with
the actual current value, but did not check if we successfully read
the current value before comparison.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It is likely that we would end up comparing the expected value with
   garbage when the read fails, and the most likely outcome is that
   they do not match and we fail the transaction, which is all fine.

   So in that sense, this is not all that urgent, but it is nice to
   fix it when we know the code is not kosher.

 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 522b19b..1db3654 100644
--- a/refs.c
+++ b/refs.c
@@ -2868,7 +2868,9 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 
 	if (old_sha1) {
 		unsigned char actual_old_sha1[20];
-		read_ref(pseudoref, actual_old_sha1);
+
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
 		if (hashcmp(actual_old_sha1, old_sha1)) {
 			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
 			rollback_lock_file(&lock);
@@ -2904,7 +2906,8 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
 					       LOCK_DIE_ON_ERROR);
 		if (fd < 0)
 			die_errno(_("Could not open '%s' for writing"), filename);
-		read_ref(pseudoref, actual_old_sha1);
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
 		if (hashcmp(actual_old_sha1, old_sha1)) {
 			warning("Unexpected sha1 when deleting %s", pseudoref);
 			rollback_lock_file(&lock);
