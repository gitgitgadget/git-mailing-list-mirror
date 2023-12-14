Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F04671E9
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8815 invoked by uid 109); 14 Dec 2023 21:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 21:49:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11686 invoked by uid 111); 14 Dec 2023 21:48:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 16:48:59 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 16:48:59 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 2/2] mailinfo: avoid recursion when unquoting From headers
Message-ID: <20231214214859.GB2798346@coredump.intra.peff.net>
References: <20231214214444.GB2297853@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231214214444.GB2297853@coredump.intra.peff.net>

Our unquote_comment() function is recursive; when it sees a comment
within a comment, like:

  (this is an (embedded) comment)

it recurses to handle the inner comment. This is fine for practical use,
but it does mean that you can easily run out of stack space with a
malicious header. For example:

  perl -e 'print "From: ", "(" x 2**18;' |
  git mailinfo /dev/null /dev/null

segfaults on my system. And since mailinfo is likely to be fed untrusted
input from the Internet (if not by human users, who might recognize a
garbage header, but certainly there are automated systems that apply
patches from a list) it may be possible for an attacker to trigger the
problem.

That said, I don't think there's an interesting security vulnerability
here. All an attacker can do is make it impossible to parse their email
and apply their patch, and there are lots of ways to generate bogus
emails. So it's more of an annoyance than anything.

But it's pretty easy to fix it. The recursion is not helping us preserve
any particular state from each level. The only flag in our parsing is
take_next_literally, and we can never recurse when it is set (since the
start of a new comment implies it was not backslash-escaped). So it is
really only useful for finding the end of the matched pair of
parentheses. We can do that easily with a simple depth counter.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailinfo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 737b9e5e13..db236f9f9f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -59,6 +59,7 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 {
 	int take_next_literally = 0;
+	int depth = 1;
 
 	strbuf_addch(outbuf, '(');
 
@@ -72,11 +73,14 @@ static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 				take_next_literally = 1;
 				continue;
 			case '(':
-				in = unquote_comment(outbuf, in);
+				strbuf_addch(outbuf, '(');
+				depth++;
 				continue;
 			case ')':
 				strbuf_addch(outbuf, ')');
-				return in;
+				if (!--depth)
+					return in;
+				continue;
 			}
 		}
 
-- 
2.43.0.363.g1d22a8f302
