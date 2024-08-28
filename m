Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3769D2B
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817539; cv=none; b=UPyIweBWbJzcrPlUg8XUpu4+fFr6X9eAJaxIqQKlZZ/UqRc6hW6Ft0GfJGaNQKX9KukyKybGWXQZjvEceOoPq51WxE9Huv69nZpoMc0ijBjFiudprIfgoCt8ljwb5hG0cRAwAA+O8knK59nAeR0DUUW/mnDeZu0kFgazPOzOq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817539; c=relaxed/simple;
	bh=/kOC549cTxlOmMkc3gDxpfVpCZlgyehth4+JNaaM9zo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPhDSKfWhy/R78sOjkm5L/Crnoyv3EPbf/XJiSGTvJA7VlZYEECkgp8APMhVTx+owxuUnQC3kobS9Zpcb5KjFws4afQy9ZEKeogXF+4Maa9T5Qn01MadHC176DKT3+lq2ocgzsO0DcBBmWGbhObW1Y0ZU3gNoxIoeWsd+VzzEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20541 invoked by uid 109); 28 Aug 2024 03:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 03:58:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23057 invoked by uid 111); 28 Aug 2024 03:58:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2024 23:58:59 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Aug 2024 23:58:55 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/6] compat: disable -Wunused-parameter in 3rd-party code
Message-ID: <20240828035855.GC3999193@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

We carry some vendored 3rd-party code in compat/ that does not build
cleanly with -Wunused-parameters. We could mark these with UNUSED, but
there are two reasons not to:

  1. This is code imported from elsewhere, so we'd prefer to avoid
     modifying it in an invasive way that could create conflicts if we
     tried to pull in a new version.

  2. These files don't include git-compat-util.h at all, so we'd need to
     factor out (or repeat) our UNUSED macro.

In theory we could modify the build process to invoke the compiler with
the extra warning disabled for these files, but there are tricky corner
cases there (e.g., for NO_REGEX we cannot assume that the compiler
understands -Wno-unused-parameter as an option, so we'd have to use our
detect-compiler script).

Instead, let's rely on the gcc diagnostic #pragma. This is horribly
unportable, of course, but it should do what we want.  Compilers which
don't understand this particular pragma should ignore it (per the
standard), and compilers which do care about "-Wunused-parameter" will
hopefully respect it, even if they are not gcc (e.g., clang does).

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/nedmalloc/nedmalloc.c | 2 ++
 compat/regex/regcomp.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 2c0ace7075..145255da43 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -31,6 +31,8 @@ DEALINGS IN THE SOFTWARE.
 /*#pragma optimize("a", on)*/
 #endif
 
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+
 /*#define FULLSANITYCHECKS*/
 
 #include "nedmalloc.h"
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 6c5d455e92..8d93a9b93f 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -17,6 +17,8 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#pragma GCC diagnostic ignored "-Wunused-parameter"
+
 #if defined __TANDEM
  /* This is currently duplicated from git-compat-utils.h */
 # ifdef NO_INTPTR_T
-- 
2.46.0.754.g24c813f009

