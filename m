From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/14] write_shared_index(): use tempfile module
Date: Mon,  8 Jun 2015 11:07:39 +0200
Message-ID: <78ffe87f5dd9037ae16a77bf9c40dcfdd9e3b40f.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2f-0002Yk-HO
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbbFHJIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:13 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46192 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbbFHJID (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:03 -0400
X-AuditID: 12074414-f79ed6d000000cef-84-55755b7107e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id EC.DF.03311.17B55755; Mon,  8 Jun 2015 05:08:01 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojW010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:01 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFsYXRpqMP+apUXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749e3mawF
	lwQqbh86zdLA+Je3i5GTQ0LARKJ53zUmCFtM4sK99WwgtpDAZUaJR6vkuxi5gOwTTBLrb5wC
	S7AJ6Eos6mkGaxARcJQ48eA6K4jNLOAgsflzIyOILQxkz/g3iQXEZhFQlbi+aSI7iM0rECVx
	9N1dqGVyEueP/2QGsTkFLCR+fd0FFOcAWmYu8WMu6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdC30cjNL9FJTSjcxQoJHZAfjkZNyhxgFOBiVeHgPLCoJFWJNLCuuzD3EKMnBpCTK
	+zGiNFSILyk/pTIjsTgjvqg0J7X4EKMEB7OSCC+TBVCONyWxsiq1KB8mJc3BoiTO+22xup+Q
	QHpiSWp2ampBahFMVoaDQ0mCd3MUUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KC7ii4GRAZLiAdrbANLOW1yQmAsUhWg9xagoJc6bB5IQAElklObBjYWlhFeM4kBfCvMyglTx
	ANMJXPcroMFMQIO/fy0GGVySiJCSamDsZz93sGLNLK0H9o+P6G3R2uZrcFJhe7xsbENw0Ta/
	miefJu4/vFdpet5ST/3avUcYDrPMWszKz3Bn/0H/vUfYWBU7uh7qss3qbmz78OVAv6DMpn2N
	e2oz/Do995+8aLFx5oP9VzjEe96vqc7t8zBdtilC6lSw1K6A+smlDqFvxP58Cbmq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271004>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 read-cache.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 3e49c49..4f7b70f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2137,54 +2137,27 @@ static int write_split_index(struct index_state *istate,
 	return ret;
 }
 
-static char *temporary_sharedindex;
-
-static void remove_temporary_sharedindex(void)
-{
-	if (temporary_sharedindex) {
-		unlink_or_warn(temporary_sharedindex);
-		free(temporary_sharedindex);
-		temporary_sharedindex = NULL;
-	}
-}
-
-static void remove_temporary_sharedindex_on_signal(int signo)
-{
-	remove_temporary_sharedindex();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static struct tempfile temporary_sharedindex;
 
 static int write_shared_index(struct index_state *istate,
 			      struct lock_file *lock, unsigned flags)
 {
 	struct split_index *si = istate->split_index;
-	static int installed_handler;
 	int fd, ret;
 
-	temporary_sharedindex = git_pathdup("sharedindex_XXXXXX");
-	fd = mkstemp(temporary_sharedindex);
+	fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
 	if (fd < 0) {
-		free(temporary_sharedindex);
-		temporary_sharedindex = NULL;
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
 	}
-	if (!installed_handler) {
-		atexit(remove_temporary_sharedindex);
-		sigchain_push_common(remove_temporary_sharedindex_on_signal);
-	}
 	move_cache_to_base_index(istate);
 	ret = do_write_index(si->base, fd, 1);
-	close(fd);
 	if (ret) {
-		remove_temporary_sharedindex();
+		delete_tempfile(&temporary_sharedindex);
 		return ret;
 	}
-	ret = rename(temporary_sharedindex,
-		     git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
-	free(temporary_sharedindex);
-	temporary_sharedindex = NULL;
+	ret = rename_tempfile(&temporary_sharedindex,
+			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret)
 		hashcpy(si->base_sha1, si->base->sha1);
 	return ret;
-- 
2.1.4
