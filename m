From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/19] read-cache: move index v2 specific functions to
 their own file
Date: Sun, 14 Jul 2013 10:10:35 +0700
Message-ID: <CACsJy8A9E5yEQZTfw6sT+2VZfDHLx5iC-mb+otRkez7f-5Mq0Q@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 05:11:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyCif-0004Mc-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 05:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab3GNDLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 23:11:08 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51617 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab3GNDLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 23:11:07 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so12568870obc.41
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 20:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1YsdlWXA7Irhg1cJdClEHubCOtOLVel9aRvQtY9Xg8k=;
        b=i4+d0wQZ8qwR+/xH2Bsn4nZVc0r3xjc7ippd3NlArJC5LAWpafTbMDJM68iAMSa9nw
         e8DWEmcPbfER6QL77hXkEs+TSt7HWIwVgc7Nj5BMgNjGbWNgBrAaS/kcLIFLoWbyix/v
         5O/10grWAosfZrFLnBk1eQRENnPx2FqNP0nlD3zk3CyCLOEvQL00c9rpuRP86iFbncQ4
         oIkf4AhC11w6K66a4+IRFHuEuH39HNM1SABHQLi7dfsnqXsPrM8fYMOcjj93rVqTEZ7x
         I1VeJwnkeSCrPybWo0XXA5x3BqriPQR52bojV9mnPK7W3zMNGk+kt9DWHt57GfPL2j8w
         iZ7A==
X-Received: by 10.182.142.104 with SMTP id rv8mr35321914obb.3.1373771465461;
 Sat, 13 Jul 2013 20:11:05 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 20:10:35 -0700 (PDT)
In-Reply-To: <1373650024-3001-4-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230301>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -489,8 +479,8 @@ extern void *read_blob_data_from_index(struct index_state *, const char *, unsig
>  #define CE_MATCH_RACY_IS_DIRTY         02
>  /* do stat comparison even if CE_SKIP_WORKTREE is true */
>  #define CE_MATCH_IGNORE_SKIP_WORKTREE  04
> -extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
> -extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
> +extern int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
> +extern int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>

I would rather we keep "const struct index_state*" if we could. I
tried putting "const" back and found that ce_match_stat_basic() calls
set_istate_ops(), which writes to "struct index_state". Putting
set_istate_ops() in ce_match_stat_basic() may seem convenient, but
does not make much sense (why would a match_stat function update
index_ops?). I think you could move it out and

 - read_index calls set_istate_ops
 - (bonus) discard_index probably should reset "version" field to zero
and clear internal_ops
 - the callers that use index without read_index must call
initialize_index() or something, which in turn calls set_istate_ops.
initialize_index() may take the preferred index version
 - do not let update-index modifies version field directly when
--index-version is given. Wrap it with set_index_version() or
something, so we can do internal conversion from one version to
another if needed
 - remove set_istate_ops in write_index(), we may need internal_ops
long before writing. When write_index is called, internal_ops should
be already initialized
--
Duy
