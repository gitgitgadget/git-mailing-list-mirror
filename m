From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix reading of split index
Date: Tue, 24 Mar 2015 18:07:55 +0100
Message-ID: <20150324170755.GA2006@hank>
References: <20150320195943.GB6545@hank>
 <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
 <1426887794-9655-3-git-send-email-t.gummerer@gmail.com>
 <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:08:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSJI-0006MA-D1
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbbCXRIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:08:07 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34609 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbbCXRIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:08:00 -0400
Received: by wgs2 with SMTP id 2so69379449wgs.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tw5QX4r6JMh0nV2WMdOGYUeV54I9n2EjIxFiqTWHH1M=;
        b=PYo+OCY5zmra3BG/eYpMepQWDJ3JWKFJau7JRKgr1A++ESye+ovgmcQAJMd9xGgG1P
         cntnzHsyhykaH46WgoiiuxxrLQyDolJjUuIlqJ0g8VC9YF2b185c7eS8vaNwyZmuj3c9
         Z3igu7FGU8UJE5eQDkddYxVetjlc5HfcjwCZOO89qJW8MIGDauZauDB9LcGiOlLJzLnP
         Z1f1w8/Qb0gZhI3C+1zg5wC8G0zDVqhPQEZZaIhG/MSxiB96NSYwXs2pM9fZfW5SM9eO
         Uy0NKm0vzYOcuPu+QUVkx02PavwJnGjwFe/cp7PDkQpwaHHKUPOnDSz2gpabDnPHFQ5i
         jZIA==
X-Received: by 10.180.79.232 with SMTP id m8mr30857804wix.81.1427216878571;
        Tue, 24 Mar 2015 10:07:58 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id r15sm388754wiw.12.2015.03.24.10.07.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 10:07:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266201>

On 03/24, Duy Nguyen wrote:
> On Sat, Mar 21, 2015 at 4:43 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > The split index extension uses ewah bitmaps to mark index entries as
> > deleted, instead of removing them from the index directly.  This can
> > result in an on-disk index, in which entries of stage #0 and higher
> > stages appear, which are removed later when the index bases are merged.
> >
> > 15999d0 read_index_from(): catch out of order entries when reading an
> > index file introduces a check which checks if the entries are in order
> > after each index entry is read in do_read_index.  This check may however
> > fail when a split index is read.
> >
> > Fix this by moving checking the index after we know there is no split
> > index or after the split index bases are successfully merged instead.
>
> Thank you for catching this. I was about to write "would be nice to
> point out what tests fail so the reviewer has easier time trying
> themselves", but whoa.. quite a few of them!
>
> May I suggest a slight modification. Even though stage info is messed
> up before the index is merged, I think we should still check that both
> front and base indexes have all the names sorted correctly (and even
> stronger, the base index should never contain staged entries). If

Hmm I just tried adding another check for that, but the base index
does seem to include staged entries sometimes.

I've tried with this, but there are quite a few test failures.  For
example in t3600-rm.sh test #52 fails, and test-dump-split-index shows
the submodule with stages 1, 2 and 3 in the index.

own 74cd8e14a8fcc5df52e5c47a3ba0c30b29e5075a
base 0ff6ae43b1caa039c2a6262f07678b88314a5b4f
160000 6daff6d0fc4a9299deb0a51881e14cdbda16b88d 1	submod
160000 ee8321115a919c0607236124af886df2c9f16e2f 2	submod
160000 f3abce3ddcc2d68a8c113bd16767deeb376276f9 3	submod
replacements:
deletions: 3

diff --git a/read-cache.c b/read-cache.c
index 2ba67ce..b502290 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1528,6 +1528,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist,
        struct cache_header *hdr;
        void *mmap;
        size_t mmap_size;
+       int fully_merged = 1;
        struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;

        if (istate->initialized)
@@ -1580,6 +1581,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist,
                ce = create_from_disk(disk_ce, &consumed, previous_name);
                set_index_entry(istate, i, ce);

+               if (ce_stage(ce)) {
+                       fully_merged = 0;
+               }
+
                if (i > 0)
                        if (check_ce_order(istate->cache[i - 1], ce, 1) > 0 &&
                            multiple_stage_entries)
@@ -1610,6 +1615,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist,
                src_offset += extsize;
        }
        munmap(mmap, mmap_size);
+       if (!fully_merged && istate->split_index)
+               die("base index cannot contain staged entries");
        return istate->cache_nr;

 unmap:


> sorting order is messed up, it could lead to other problems. So
> instead of removing the test from do_read_index(), perhaps add a flag
> in check_ce_order() to optionally detect the stage problem, but
> print/do nothing, only set a flag so the caller know there may be a
> problem. In the two new call sites you added, we still call the new
> check_ce_order() again to make sure everything is in order. In the
> call site where split index is not active, if the previous
> check_ce_order() call from inside do_read_index() says "everything is
> ok", we could even skip the check.
> --
> Duy

--
Thomas Gummerer
