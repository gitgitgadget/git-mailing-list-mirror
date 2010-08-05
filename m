From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/12] Documentation/technical: document ll_merge
Date: Thu, 5 Aug 2010 06:16:51 -0500
Message-ID: <20100805111651.GH13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:18:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgySn-0004eO-KN
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759022Ab0HELSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:18:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36141 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab0HELSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:18:12 -0400
Received: by iwn33 with SMTP id 33so84270iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xDAGOvtlES4/olpFF5F3ujlqDI2JDT39t2brwoinrUU=;
        b=weskodbfpmLZmtWsrJFwhVpkh262310wuTn8L1g1RB/EFv1HVIhGgifXPDYWl6kR0W
         8LXWc5VjhW6XJyml6FUYdBVn8Bw507NA19ZmC3ryUPPULXNLH5O/QV5NUbUzpWp1wHhj
         TrHiNivbxZeF5EP74KKz3V9KE93BCDReOwcyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xVQ56IEipstGP0BcWT8qbeDlCLnLYgEOwCMwU0DOft4d1ay/I7gsu9QOcOGgRTQmd/
         Qpvu6Hf0681Y1TD2nn3YRSr35SAlKFF6bDn0EVUCS5cjg6arlpa/K739zzStaBONZOmo
         G/hB2IWiZCTqqBFEndtASzOCLALa9lAwNS7Pc=
Received: by 10.231.139.212 with SMTP id f20mr11474468ibu.166.1281007091765;
        Thu, 05 Aug 2010 04:18:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm54710ibk.1.2010.08.05.04.18.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:18:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152638>

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sane?

 Documentation/technical/api-merge.txt |   70 +++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-merge.txt

diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
new file mode 100644
index 0000000..01a89d6
--- /dev/null
+++ b/Documentation/technical/api-merge.txt
@@ -0,0 +1,70 @@
+merge API
+=========
+
+The merge API helps a program to reconcile two competing sets of
+improvements to some files (e.g., unregistered changes from the work
+tree versus changes involved in switching to a new branch), reporting
+conflicts if found.  The library called through this API is
+responsible for a few things.
+
+ * determining which trees to merge (recursive ancestor consolidation);
+
+ * lining up corresponding files in the trees to be merged (rename
+   detection, subtree shifting), reporting edge cases like add/add
+   and rename/rename conflicts to the user;
+
+ * performing a three-way merge of corresponding files, taking
+   path-specific merge drivers (specified in `.gitattributes`)
+   into account.
+
+Low-level (single file) merge
+-----------------------------
+
+`ll_merge`::
+
+	Perform a three-way single-file merge in core.  This is
+	a thin wrapper around `xdl_merge` that takes the path and
+	any merge backend specified in `.gitattributes` or
+	`.git/info/attributes` into account.  Returns 0 for a
+	clean merge.
+
+The caller:
+
+1. allocates an mmbuffer_t variable for the result;
+2. allocates and fills variables with the file's original content
+   and two modified versions (using `read_mmfile`, for example);
+3. calls ll_merge();
+4. reads the output from result_buf.ptr and result_buf.size;
+5. releases buffers when finished (free(ancestor.ptr); free(ours.ptr);
+   free(theirs.ptr); free(result_buf.ptr);).
+
+If the modifications do not merge cleanly, `ll_merge` will return a
+nonzero value and `result_buf` will generally include a description of
+the conflict bracketed by markers such as the traditional `<<<<<<<`
+and `>>>>>>>`.
+
+The `ancestor_label`, `our_label`, and `their_label` parameters are
+used to label the different sides of a conflict if the merge driver
+supports this.
+
+The `flag` parameter is a bitfield:
+
+ - The least significant bit indicates whether this is an internal
+   merge to consolidate ancestors for a recursive merge.
+
+ - The next two bits allow local conflicts to be automatically
+   resolved in favor of one side or the other (as in 'git merge-file'
+   `--ours`/`--theirs`/`--union` for 01, 10, and 11, respectively).
+
+Everything else
+---------------
+
+Talk about <merge-recursive.h> and merge_file():
+
+ - merge_trees() to merge with rename detection
+ - merge_recursive() for ancestor consolidation
+ - try_merge_command() for other strategies
+ - conflict format
+ - merge options
+
+(Daniel, Miklos, Stephan, JC)
-- 
1.7.2.1.544.ga752d.dirty
