Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CDB285041
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934389; cv=none; b=D0dHSTiAuqnD8nQxWp9pPQlK18rKnL17J9Yv4TzbexlRvifsZ9KUNBHvOOhBfnx0cfwjDixmL+LuP4yOWr7UXnDAkIkhZFAHP+DADen/R4qCIYJRMS8+CXRQHmjrM13XZVeHEawUSfio72g+qY9eb0d05SoQMRi0h5UXCZ8UaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934389; c=relaxed/simple;
	bh=RH1uMljWU5HGlFWBkdqLuVTP21FQHIpa9oRI9r3I9po=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ktJx3x3jN8KXMfI5ZeE0fWNvgVXaXhCOaRix64nlKWTo0zWM9wnVT3kEnDPsC/MCxH0o7tJAnYtlMWaXtnvoi0LSNQiuS8r/n81K6yMWJJMQg+QXLtPYaIJdjWbsKRiK6B0HzhxKYQ5/W4ulJjSMN6piAdL9oo2Y1Bl4lkBU2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KXs6Nax3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KXs6Nax3"
Received: (qmail 317858 invoked by uid 106); 11 Apr 2026 19:06:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=RH1uMljWU5HGlFWBkdqLuVTP21FQHIpa9oRI9r3I9po=; b=KXs6Nax3ZtualUxXy8L9/X27XmhtnazCae17ZW5THlhzXaG8cxeV92xFqjZ2o2RjRccKKTKrwNKyWCim1z5Uj2BafSA+W6bwRNPpJ3Bgy2liG59R6szHI/M3P5ywUgHcnpfZ9MbxYZ8WzNVqL5R/jOV5PYq0V7PbM2T7x6FDFUX/YlIXIjaAmBmz6eXkSfPPuy8xS+WsUeO8FSKW7S1Gte89yHeNE9E9a6RWc10hxMjEnR5BZluyCiBcOy/7mHciwSMGPX8FfqFEzxMdVgnTsAyEDq2UTu7L3FRl48P8t4ASj7y32RJc8iOOFGZIsSWtTaOOUuN/QmZxwpbOZda3pA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Apr 2026 19:06:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 525145 invoked by uid 111); 11 Apr 2026 19:06:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Apr 2026 15:06:25 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Apr 2026 15:06:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] gitglossary: fix indentation of sub-lists
Message-ID: <20260411190625.GA754966@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The glossary entry is a list of terms and their definitions, so
multi-paragraph definitions need "+" continuation lines to indicate
that they are part of a single entry.

When an entry contains a sub-list (say, a bulleted list), the final "+"
may become ambiguous: is it connecting the next paragraph to the final
entry of the sub-list, or to the original list of definition paragraphs?

Asciidoc generally connects it to the former, even when we mean the
latter, and you end up with the next paragraph indented incorrectly,
like this:

  glob
    ...defines glob...

    Two consecutive asterisks ("**") in patterns matched
    against full pathname may have special meaning:

    - ...some special meaning of **...

    - ...another special meaning of **...

    - Other consecutive asterisks are considered invalid.

      Glob magic is incompatible with literal magic.

That final "Glob magic is incompatible" paragraph is in the wrong spot.
It should be at the same level as "Two consecutive asterisks", as it is
not part of the final "Other consecutive asterisks" bullet point.

The same problem appears in several other spots in the glossary.

We can fix this by using "--" markers, which put the sub-list into its
own block. This should catch all of the unordered lists in the glossary,
which I found by grepping for " -" list markers.

Signed-off-by: Jeff King <peff@peff.net>
---
Just happened to notice this while looking at the "ref" entry.

 Documentation/glossary-content.adoc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 20ba121314..8967e89ece 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -415,7 +415,8 @@ glob;;
 +
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
-
++
+--
  - A leading "`**`" followed by a slash means match in all
    directories. For example, "`**/foo`" matches file or directory
    "`foo`" anywhere. "`**/foo/bar`" matches file or directory "`bar`"
@@ -430,6 +431,7 @@ full pathname may have special meaning:
    matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
 
  - Other consecutive asterisks are considered invalid.
+--
 +
 Glob magic is incompatible with literal magic.
 
@@ -442,7 +444,8 @@ See linkgit:gitattributes[5].
 +
 Each of the attribute requirements for the path takes one of
 these forms:
-
++
+--
 - "`ATTR`" requires that the attribute `ATTR` be set.
 
 - "`-ATTR`" requires that the attribute `ATTR` be unset.
@@ -452,6 +455,7 @@ these forms:
 
 - "`!ATTR`" requires that the attribute `ATTR` be
   unspecified.
+--
 +
 Note that when matching against a tree object, attributes are still
 obtained from working tree, not from the given tree object.
@@ -560,14 +564,17 @@ The ref namespace is hierarchical.
 Ref names must either start with `refs/` or be located in the root of
 the hierarchy. For the latter, their name must follow these rules:
 +
+--
  - The name consists of only upper-case characters or underscores.
 
  - The name ends with "`_HEAD`" or is equal to "`HEAD`".
+--
 +
 There are some irregular refs in the root of the hierarchy that do not
 match these rules. The following list is exhaustive and shall not be
 extended in the future:
 +
+--
  - `AUTO_MERGE`
 
  - `BISECT_EXPECTED_REV`
@@ -577,6 +584,7 @@ extended in the future:
  - `NOTES_MERGE_REF`
 
  - `MERGE_AUTOSTASH`
+--
 +
 Different subhierarchies are used for different purposes. For example,
 the `refs/heads/` hierarchy is used to represent local branches whereas
-- 
2.54.0.rc1.279.g55df28c202
