From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix archive format with -- on the command line
Date: Sat, 12 Dec 2009 16:00:41 +0100
Message-ID: <4B23B019.40106@lsrfire.ath.cx>
References: <20091210212636.GA27722@Knoppix> <7v1vj2a3ik.fsf@alter.siamese.dyndns.org> <20091210222258.GQ4114@genesis.frugalware.org> <7vws0u8n99.fsf@alter.siamese.dyndns.org> <7vhbry8l54.fsf_-_@alter.siamese.dyndns.org> <7vd42m8kyr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 03:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJe0d-0001by-DB
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 03:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbZLMCQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 21:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756865AbZLMCQU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 21:16:20 -0500
Received: from india601.server4you.de ([85.25.151.105]:52936 "HELO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756827AbZLMCQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 21:16:19 -0500
Received: from [10.0.1.101] (p57B7F6F9.dip.t-dialin.net [87.183.246.249])
	by india601.server4you.de (Postfix) with ESMTPSA id 4EA9A2F804F;
	Sat, 12 Dec 2009 16:00:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vd42m8kyr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135147>

Am 11.12.2009 00:31, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Giving --format from the command line, or using output file extention to
>> DWIM the output format, with a pathspec that is disambiguated with an
>> explicit double-dash on the command line, e.g.
>>
>>     git archive -o file --format=zip HEAD -- path
>>     git archive -o file.zip HEAD -- path
>>
>> didn't work correctly.
>>
>> This was because the code reordered (when one was given) or added (when
>> the former was inferred) a --format argument at the end, effectively
>> making it to "archive HEAD -- path --format=zip", i.e. an extra pathspec
>> that is unlikely to match anything.
> 
> A side note to this issue is that
> 
>     $ git add non-existing-path
> 
> complains but
> 
>     $ git archive HEAD non-existing-path
> 
> doesn't.  Is this something we should consider a bug, or a feature?

I wouldn't go so far as to call it a bug, but it's certainly a missing
feature.  If the user asks for something we can't give him or her, it's
better to report that fact.  We didn't do that because it doesn't fall
out naturally from the archive streaming loop.  ls-tree doesn't do it,
either, by the way.

Something like this?

-- >8 --
Subject: archive: complain about path specs that don't match anything

Verify that all path specs match at least one path in the specified
tree and reject those that don't.

This would have made the bug fixed by 782a0005 easier to find.

This implementation is simple to the point of being stupid.  It walks
the full tree for each path spec until it matches something.  It's short
and seems to be fast enough, though.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index 55b2732..5b88507 100644
--- a/archive.c
+++ b/archive.c
@@ -211,10 +211,33 @@ static const struct archiver *lookup_archiver(const char *name)
 	return NULL;
 }
 
+static int reject_entry(const unsigned char *sha1, const char *base,
+			int baselen, const char *filename, unsigned mode,
+			int stage, void *context)
+{
+	return -1;
+}
+
+static int path_exists(struct tree *tree, const char *path)
+{
+	const char *pathspec[] = { path, NULL };
+
+	if (read_tree_recursive(tree, "", 0, 0, pathspec, reject_entry, NULL))
+		return 1;
+	return 0;
+}
+
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec = get_pathspec("", pathspec);
+	ar_args->pathspec = pathspec = get_pathspec("", pathspec);
+	if (pathspec) {
+		while (*pathspec) {
+			if (!path_exists(ar_args->tree, *pathspec))
+				die("path not found: %s", *pathspec);
+			pathspec++;
+		}
+	}
 }
 
 static void parse_treeish_arg(const char **argv,
