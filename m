Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C57D096
	for <git@vger.kernel.org>; Wed, 22 May 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387050; cv=none; b=Dp/k/Ovr2fDy4YwgXCxTGfgqy6foY5ONfIr6oYSGu/82+fagNsjNXBTQ7LGGeZaI9+h4pcyotQlkS5pBdAj0/2mc5zOjRvui7njoBDK8ii5263Qp0jrAb8FKEzO4TSDZxVYTQdBdwMMeuQ3d3FMh6E8i15pPS+m742zgr8NzEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387050; c=relaxed/simple;
	bh=LJMrqTpuF0Dn3xD2ZDK3sYoXVJjZ+rV0gx4oJAscB8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBR2QX2P3rDZViC/XDdgNvQMGLipZynozF8cG59aItZcpucWy23r5gKA2wetHKlWNJvm71BX/HR4qrdauFftj/trv8ovusrQ8SWg8i0JSNKPGEbHxrI9SqI5kSkhoCWB3nbxf9b4k01RlhFBC9J5Gwxqm2q5pNpSMPzFwH7jhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=tgQ+E1Lm; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="tgQ+E1Lm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uoazPGlTGHWbrnvticq96kRUgFmjGPWf53ofeFoceC0=; i=tom@compton.nu;
	t=1716387048; x=1717596648; b=tgQ+E1LmVRlmmuPg64U1MOOSPLJwO+9ngIGn8qgGuk1yE6q
	w2vk68cgqX7lKbIElKgTf+ovkKOsdtO+dLnexyiBXNWNSm4nAPfnlMuN1HVbemOnHSqH5d1Qp1xIB
	TI7EzuCkuIXWTbZ0m/qllABXC4QgAOLG4j4B7qd2Zqyve1rXI9n3wKX3WqDeVkR3+WXytO8i4VrwP
	TFZ5DDZgnVsjK6BQXSfdldw30ZuuaWbu13V+2/QCh12pMZ1LeW6S54mw4ZMAEQ+G+M9KqjergtBeo
	ns9d6748Cwscn9xAcM7iqXwxy4Wkk/UNwXTyB105JLui5KVgMrthWED2IDtvLtPg==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:52194)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9m92-00000007dOb-064H;
	Wed, 22 May 2024 14:36:44 +0100
Received: from tom by bericote.compton.nu with local (Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9m91-00000005UPS-3n1Q;
	Wed, 22 May 2024 14:36:39 +0100
From: Tom Hughes <tom@compton.nu>
To: git@vger.kernel.org
Cc: Tom Hughes <tom@compton.nu>
Subject: [PATCH] push: don't fetch commit object when checking existence
Date: Wed, 22 May 2024 14:36:21 +0100
Message-ID: <20240522133621.1308393-1-tom@compton.nu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're checking to see whether to tell the user to do a fetch
before pushing there's no need for us to actually fetch the object
from the remote if the clone is partial.

Because the promisor doesn't do negotiation actually trying to do
the fetch of the new head can be very expensive as it will try and
include history that we already have and it just results in rejecting
the push with a different message, and in behavior that is different
to a clone that is not partial.

Signed-off-by: Tom Hughes <tom@compton.nu>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 2b650b813b..20395bbbd0 100644
--- a/remote.c
+++ b/remote.c
@@ -1773,7 +1773,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!repo_has_object_file(the_repository, &ref->old_oid))
+			else if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
-- 
2.45.1

