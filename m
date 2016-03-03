From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index-pack: correct --keep[=<msg>]
Date: Thu, 03 Mar 2016 11:14:46 -0800
Message-ID: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 20:15:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abYi9-0000hE-Va
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 20:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758045AbcCCTOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 14:14:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758012AbcCCTOy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 14:14:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2ECB849C25;
	Thu,  3 Mar 2016 14:14:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	NsrWHCRn6Wm/nCcflk2XVw+IQA=; b=MKrrmp+MvQjEdPgH0NimC90EqXRnhZZ6J
	jRfUWLodQ7+nrLuFT93S20HznC4sKrNBmDxfLSXuYeQOH02S8ddOdRKklB4xUvpw
	MtTzR2sN84lEP+XpGG1phat4jsKUEPGVjBg2+YORheZtYW0/285SM0OD2cSgXnss
	eZpUHA9dkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=odz
	pNCwhtG6VmDQCSlmIWoxri9NVYhZb2E9zXK3lwcc+AijiMfiV4mEZV62io627VxU
	+TQp0g0cIENp/fpw4nbW0ndNV4jEagCd2KjgzfODcsovaVIXW915EDL/V3vlMiTA
	UkJp0ev+W73+TzNaM5dYFMf3foUAKvFV58oh6Wig=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 272AF49C23;
	Thu,  3 Mar 2016 14:14:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9AA1349C22;
	Thu,  3 Mar 2016 14:14:47 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3207A2F0-E174-11E5-A1A1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288205>

When 592ce208 (index-pack: use strip_suffix to avoid magic numbers,
2014-06-30) refactored the code to derive names of .idx and .keep
files from the name of .pack file, a copy-and-paste typo crept in,
mistakingly attempting to create and store the keep message file in
the .idx file we just created, instead of .keep file.

As we create the .keep file with O_CREAT|O_EXCL, and we do so after
we write the .idx file, we luckily do not clobber the .idx file, but
because we deliberately ignored EEXIST when creating .keep file
(which is justifiable because only the existence of .keep file
matters), nobody noticed this mistake so far.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In a later patch, I'll be adding another file to the family of
   .pack/.idx/.keep files, and the body of these if() statements
   would be made into a helper function when it happens.  This is to
   fix it directly on top of the problematic commit without such a
   helper, the result of which could be merged to 2.1.x and later
   maintenance series.

 builtin/index-pack.c   | 2 +-
 t/t5300-pack-object.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d4b77fd..3814731 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1617,7 +1617,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
 		strbuf_add(&keep_name_buf, pack_name, len);
-		strbuf_addstr(&keep_name_buf, ".idx");
+		strbuf_addstr(&keep_name_buf, ".keep");
 		keep_name = keep_name_buf.buf;
 	}
 	if (verify) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 20c1961..0e3cadf 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -284,6 +284,12 @@ test_expect_success \
      git index-pack test-3.pack &&
      cmp test-3.idx test-3-${packname_3}.idx &&
 
+     cat test-1-${packname_1}.pack >test-4.pack &&
+     rm -f test-4.keep &&
+     git index-pack --keep=why test-4.pack &&
+     cmp test-1-${packname_1}.idx test-4.idx &&
+     test -f test-4.keep &&
+
      :'
 
 test_expect_success 'unpacking with --strict' '
-- 
v2.0.1-6-g592ce20
