From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [RFC/PATCH v2] tag: disallow '-' as tag name
Date: Tue, 10 May 2011 11:47:03 +0200
Message-ID: <4DC90997.4060208@elegosoft.com>
References: <1304954496.11377.11.camel@kohr-ah> <7v39knpxbe.fsf@alter.siamese.dyndns.org> <4DC87113.4030204@elegosoft.com> <7v62pjo4km.fsf@alter.siamese.dyndns.org> <4DC87A84.4070604@elegosoft.com> <BANLkTik7PYjGMMfxaNPubYR7M1OgBrF_qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Alex Vandiver <alex@chmrr.net>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 11:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJjXT-0008Ot-GM
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 11:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1EJJrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 05:47:18 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:56387 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab1EJJrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 05:47:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 91729DE0BC;
	Tue, 10 May 2011 11:47:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 61+YxtNZCvfc; Tue, 10 May 2011 11:47:04 +0200 (CEST)
Received: from [10.10.10.226] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1A8B2DE0AB;
	Tue, 10 May 2011 11:47:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
In-Reply-To: <BANLkTik7PYjGMMfxaNPubYR7M1OgBrF_qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173323>

On 05/10/2011 09:07 AM, Sverre Rabbelier wrote:
>> Disallow '-' as tag name just as any tag name starting with '-' to be
>> consistent with "git checkout".
> 
> This was hard for me to parse, how about::
> 
> Disallow '-' as tag name, as well as tag names starting with '-', to
> be consistent with "git checkout".

Thanks.

-- >8 --
Subject: [PATCH] tag: disallow '-' as tag name

Disallow '-' as tag name, as well as tag names starting with '-', to be
consistent with "git checkout".

Add strbuf_check_tag_ref() as helper to check a refname for a tag.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/tag.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index b66b34a..ec926fc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -352,11 +352,22 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
+{
+	if (name[0] == '-')
+		return CHECK_REF_FORMAT_ERROR;
+
+	strbuf_reset(sb);
+	strbuf_addf(sb, "refs/tags/%s", name);
+
+	return check_ref_format(sb->buf);
+}
+
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
-	char ref[PATH_MAX];
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
 
@@ -452,12 +463,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
-	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) > sizeof(ref) - 1)
-		die(_("tag name too long: %.*s..."), 50, tag);
-	if (check_ref_format(ref))
+	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
 
-	if (!resolve_ref(ref, prev, 1, NULL))
+	if (!resolve_ref(ref.buf, prev, 1, NULL))
 		hashclr(prev);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
@@ -466,14 +475,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		create_tag(object, tag, &buf, msg.given || msgfile,
 			   sign, prev, object);
 
-	lock = lock_any_ref_for_update(ref, prev, 0);
+	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-		die(_("%s: cannot lock the ref"), ref);
+		die(_("%s: cannot lock the ref"), ref.buf);
 	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref);
+		die(_("%s: cannot update the ref"), ref.buf);
 	if (force && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
 	strbuf_release(&buf);
+	strbuf_release(&ref);
 	return 0;
 }
-- 
1.7.5.1
