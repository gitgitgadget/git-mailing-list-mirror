Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09874F4CF0
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574644; cv=none; b=IqWVAsrlvW9lrrab7oM4UAMsoQSKWDelU7xeXi48hjdTGMH9p9HizWBYrTBGtTJZd02dCaVlwo+oEZTsi61eemEm/b8H9l6OvVgxgyVVKZCchcySWbxGN0groAjSwBB9jLR6BwCyb3GXlGekNFR4NNNVoLpKrH2kpAl2yj4pxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574644; c=relaxed/simple;
	bh=ORAwWrf52xXXQLFpfSKEmFWHeS4OCDV76yH9I46XlOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWZ3XY8mj9/p+IUXyDx/sA6ihDfMpzgoKnnby4s1hCbYHm0AAklaS2uqXN3rvu6De0pCY23KCkpx83hNPAdaxu/MRFnyzLeP5hNi5uNbPL5u6MEyiTAES8Ay4KeuAoyDxvLVD7y4H4InAeKM7jdQsnPt9BaZzgzG9cs5spXWlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=c+hoXhqd; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="c+hoXhqd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574224;
	bh=ORAwWrf52xXXQLFpfSKEmFWHeS4OCDV76yH9I46XlOc=;
	h=From:To:Subject:Date:From;
	b=c+hoXhqdGUYk1EWkQM+x/GZKjhyAschww/Y8AxGIU7NgbhI4ehhpw8JEcFfJmBZac
	 cpK01HJ72SxxNM2YPu0aGbEUdg1Odo2sMhO9P+EwZxH5xlH00lCAnOUwaHmMGSE/gL
	 Mj430E9zqaYUwIXDVUi+hiEwOtS6pErFttLf5dYI=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id CE40720396;
	Fri,  9 Oct 2026 15:30:23 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 13/15] t/perf: measure --force-with-lease in p5516
Date: Fri,  9 Oct 2026 15:29:51 -0400
Message-ID: <20261009192953.81794-14-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-14-1

Extend p5516 with rows that push the same delete refspecs plus one
explicit --force-with-lease=<refname>:<expect> per refspec.

The new rows are used to demonstrate a speedup in a subsequent commit.

Numbers as of this commit
(`./p5516-push-delete-refspec.sh -r create,lease`):

  Test                        this tree
  -------------------------------------------
  5516.16: empty:lease:1      0.12(0.06+0.10)
  5516.19: empty:lease:10     0.17(0.10+0.10)
  5516.22: empty:lease:100    0.45(0.38+0.10)
  5516.25: mirror:lease:1     0.15(0.09+0.10)
  5516.28: mirror:lease:10    0.18(0.12+0.10)
  5516.31: mirror:lease:100   0.52(0.42+0.10)

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/perf/p5516-push-delete-refspec.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/perf/p5516-push-delete-refspec.sh b/t/perf/p5516-push-delete-refspec.sh
index 0e425193e5..a1e3f74bf7 100755
--- a/t/perf/p5516-push-delete-refspec.sh
+++ b/t/perf/p5516-push-delete-refspec.sh
@@ -6,6 +6,9 @@ Measure client-side matching of explicit delete refspecs with "git push
 --dry-run" against a server that advertises lots of refs.  An empty client
 (no local refs) and a mirror client (full local copy of the server refs)
 are tested pushing 1, 10, and 100 refspecs each.
+
+A second set of rows measures one --force-with-lease per refspec for
+timing those paths.
 '
 . ./perf-lib.sh
 
@@ -24,6 +27,8 @@ test_expect_success 'create server with many refs and two clients' '
 	git -C client_mirror config --unset remote.origin.mirror
 '
 
+oid=$(git -C server rev-parse HEAD)
+
 for mode in empty mirror
 do
 	client=client_$mode
@@ -39,4 +44,24 @@ do
 	done
 done
 
+for mode in empty mirror
+do
+	client=client_$mode
+	for nr_refspecs in 1 10 100
+	do
+		test_expect_success "create $mode lease refspecs: $nr_refspecs" '
+			test_seq -f ":refs/heads/b%d" $nr_refspecs >refspecs
+		'
+
+		test_expect_success "create $mode leases: $nr_refspecs" '
+			test_seq -f "refs/heads/b%d:'"$oid"'" $nr_refspecs |
+			sed "s/^/--force-with-lease=/" >leases
+		'
+
+		test_perf "$mode:lease:$nr_refspecs" '
+			git -C '"$client"' push --dry-run origin $(cat refspecs) $(cat leases)
+		'
+	done
+done
+
 test_done
-- 
2.55.0

