Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BNS/g1ev"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C0D63
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:07:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77d85cf1ff5so218508185a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198475; x=1701803275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AiILbpundpCOjZhzftzS93xFavUvm0MdEIVCWd6/Jg=;
        b=BNS/g1evc3nKaIwUpsrglgoJ3yuVB54L0b8QqvycpoLOc87IGer4H6QvmfG6xGMEs3
         dbtY8jioTXvriBIAhrtugEGaVDBpIQO0DoVI3Jp6slgiQgVX9K82KilPajnWYsDLipXT
         AnTm+UD/qgKZ6YDRadYTese57U66a1Q0687E9HhzAvBBjsbPmv0D+nsMbbmF2XFtz8Xx
         Mb/4jhcCfStkJjOvp76IQ4hK9FEzrwPZ6UtAZj5nk+waPte1FNFb7BjDKHT5J5vNRPce
         +0P5/6n297Ccw9Q/ZGT0x9Rf39XrrC0jwoL0OOvqi3ZQtdErtkpF9g80m9EoGkUCAFOE
         laKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198475; x=1701803275;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AiILbpundpCOjZhzftzS93xFavUvm0MdEIVCWd6/Jg=;
        b=rr/FhkmANfA71m/2hsrkzmtFXUnZqMxcQJ0YDE9LXqU2khr767XGUwWUg1FmDYa46U
         zPm8muP3iPJpZCuv4q1BXMpHY9fC1niyQWo0TDlvNQAtKHeTFOL58mAckRHlM6tnIYf3
         OSdoRz/bBADkRb97G+JLA0dDaYpk+9HpIGDybjQetPwj+jiqk7nDjvwyodC1xtoKDELx
         ZwR67HqlClSUG8/MzX5rhQdhz7Eug/toJk00cxPUFAJKX25cU0Lg/uHa900auc/6UQB6
         r50WW+clx3lkyH5gOqQnoJjciDpQ5BTJiS07JfBZ4X0ofJJB7RtyeMTlsFzdE1FcnzlN
         wMAA==
X-Gm-Message-State: AOJu0YxPDGBVSIOri6A+jj6aImS0ZgVxEZWk46BGXfBIATEm0zjC9DjN
	jPNgbXRHrX1vF9WK/BCHMjOZX8NjwdQuv94134U=
X-Google-Smtp-Source: AGHT+IED6/E380+m16qL/+qmnZCw1Dtoy2MO3LJcB1AzeAZUx4AezOe+FQZRq1eTqLHgKE6YxciS0w==
X-Received: by 2002:a05:620a:4897:b0:76f:fe8:7ffd with SMTP id ea23-20020a05620a489700b0076f0fe87ffdmr21174613qkb.69.1701198475556;
        Tue, 28 Nov 2023 11:07:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id tp13-20020a05620a3c8d00b0077d72f820adsm4695197qkn.115.2023.11.28.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:07:55 -0800 (PST)
Date: Tue, 28 Nov 2023 14:07:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Back in fff42755ef (pack-bitmap: add support for bitmap indexes,
2013-12-21), we added support for reachability bitmaps, and taught
pack-objects how to reuse verbatim chunks from the bitmapped pack. When
multi-pack bitmaps were introduced, this pack-reuse mechanism evolved to
use the MIDX's "preferred" pack as the source for verbatim reuse.

This allows repositories to incrementally repack themselves (e.g., using
a `--geometric` repack), storing the result in a MIDX, and generating a
corresponding bitmap. This keeps our bitmap coverage up-to-date, while
maintaining a relatively small number of packs.

However, it is recommended (and matches what we do in production at
GitHub) that repositories repack themselves all-into-one, and
generate a corresponding single-pack reachability bitmap. This is done
for a couple of reasons, but the most relevant one to this series is
that it enables us to perform verbatim pack-reuse over a complete copy
of the repository, since the entire repository resides in a single pack
(and thus is eligible for verbatim pack-reuse).

As repositories grow larger, packing their contents into a single pack
becomes less feasible. This series extends the pack-reuse mechanism to
operate over multiple packs which are known ahead of time to be disjoint
with respect to one another's set of objects.

The implementation has a few components:

  - A new MIDX chunk called "Disjoint packfiles" or DISP is introduced
    to keep track of the bitmap position, number of objects, and
    disjointed-ness for each pack contained in the MIDX.

  - A new mode for `git multi-pack-index write --stdin-packs` that
    allows specifying disjoint packs, as well as a new option
    `--retain-disjoint` which preserves the set of existing disjoint
    packs in the new MIDX.

  - A new pack-objects mode `--ignore-disjoint`, which produces packs
    which are disjoint with respect to the current set of disjoint packs
    (i.e. it discards any objects from the packing list which appear in
    any of the known-disjoint packs).

  - A new repack mode, `--extend-disjoint` which causes any new pack(s)
    which are generated to be disjoint with respect to the set of packs
    currently marked as disjoint, minus any pack(s) which are about to
    be deleted.

With all of that in place, the patch series then rewrites all of the
pack-reuse functions in terms of the new `bitmapped_pack` structure.
Once we have dropped all of the assumptions stemming from only
performing pack-reuse over a single candidate pack, we can then enable
reuse over all of the disjoint packs.

In addition to the many new tests in t5332 added by that series, I tried
to simulate a "real world" test on git.git by breaking the repository
into chunks of 1,000 commits (plus their set of reachable objects not
reachable from earlier chunk(s)) and packing those chunks. This produces
a large number of packs with the objects from git.git which are known to
be disjoint with respect to one another.

    $ git clone git@github.com:git/git.git base

    $ cd base
    $ mv .git/objects/pack/pack-*.idx{,.bak}
    $ git unpack-objects <.git/objects/pack/pack-*.pack

    # pack the objects from each successive block of 1k commits
    $ for rev in $(git rev-list --all | awk '(NR) % 1000 == 0' | tac)
      do
        echo $rev |
        git.compile pack-objects --revs --unpacked .git/objects/pack/pack || return 1
      done
    # and grab any stragglers, pruning the unpacked objects
    $ git repack -d
    I then constructed a MIDX and corresponding bitmap

    $ find_pack () {
        for idx in .git/objects/pack/pack-*.idx
        do
          git show-index <$idx | grep -q "$1" && basename $idx
        done
      }
    $ preferred="$(find_pack $(git rev-parse HEAD))"

    $ ( cd .git/objects/pack && ls -1 *.idx ) | sed -e 's/^/+/g' |
        git.compile multi-pack-index write --bitmap --stdin-packs \
          --preferred-pack=$preferred
    $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in

With all of that in place, I was able to produce a significant speed-up
by reusing objects from multiple packs:

    $ hyperfine -L v single,multi -n '{v}-pack reuse' 'git.compile -c pack.allowPackReuse={v} pack-objects --revs --stdout --use-bitmap-index --delta-base-offset <in >/dev/null'
    Benchmark 1: single-pack reuse
      Time (mean ± σ):      6.094 s ±  0.023 s    [User: 43.723 s, System: 0.358 s]
      Range (min … max):    6.063 s …  6.126 s    10 runs

    Benchmark 2: multi-pack reuse
      Time (mean ± σ):     906.5 ms ±   3.2 ms    [User: 1081.5 ms, System: 30.9 ms]
      Range (min … max):   903.5 ms … 912.7 ms    10 runs

    Summary
      multi-pack reuse ran
        6.72 ± 0.03 times faster than single-pack reuse

(There are corresponding tests in p5332 that test different sized chunks
and measure the runtime performance as well as resulting pack size).

Performing verbatim pack reuse naturally trades off between CPU time and
the resulting pack size. In the above example, the single-pack reuse
case produces a clone size of ~194 MB on my machine, while the
multi-pack reuse case produces a clone size closer to ~266 MB, which is
a ~37% increase in clone size.

I think there is still some opportunity to close this gap, since the
"packing" strategy here is extremely naive. In a production setting, I'm
sure that there are more well thought out repacking strategies that
would produce more similar clone sizes.

I considered breaking this series up into smaller chunks, but was
unsatisfied with the result. Since this series is rather large, if you
have alternate suggestions on better ways to structure this, please let
me know.

Thanks in advance for your review!

Taylor Blau (24):
  pack-objects: free packing_data in more places
  pack-bitmap-write: deep-clear the `bb_commit` slab
  pack-bitmap: plug leak in find_objects()
  midx: factor out `fill_pack_info()`
  midx: implement `DISP` chunk
  midx: implement `midx_locate_pack()`
  midx: implement `--retain-disjoint` mode
  pack-objects: implement `--ignore-disjoint` mode
  repack: implement `--extend-disjoint` mode
  pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
  pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
  pack-bitmap: return multiple packs via
    `reuse_partial_packfile_from_bitmap()`
  pack-objects: parameterize pack-reuse routines over a single pack
  pack-objects: keep track of `pack_start` for each reuse pack
  pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
  pack-objects: prepare `write_reused_pack()` for multi-pack reuse
  pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack
    reuse
  pack-objects: include number of packs reused in output
  pack-bitmap: prepare to mark objects from multiple packs for reuse
  pack-objects: add tracing for various packfile metrics
  t/test-lib-functions.sh: implement `test_trace2_data` helper
  pack-objects: allow setting `pack.allowPackReuse` to "single"
  pack-bitmap: reuse objects from all disjoint packs
  t/perf: add performance tests for multi-pack reuse

 Documentation/config/pack.txt          |   8 +-
 Documentation/git-multi-pack-index.txt |  12 ++
 Documentation/git-pack-objects.txt     |   8 +
 Documentation/git-repack.txt           |  12 ++
 Documentation/gitformat-pack.txt       | 109 ++++++++++
 builtin/multi-pack-index.c             |  13 +-
 builtin/pack-objects.c                 | 200 +++++++++++++++----
 builtin/repack.c                       |  57 +++++-
 midx.c                                 | 218 +++++++++++++++++---
 midx.h                                 |  11 +-
 pack-bitmap-write.c                    |   9 +-
 pack-bitmap.c                          | 265 ++++++++++++++++++++-----
 pack-bitmap.h                          |  18 +-
 pack-objects.c                         |  15 ++
 pack-objects.h                         |   1 +
 t/helper/test-read-midx.c              |  31 ++-
 t/lib-disjoint.sh                      |  49 +++++
 t/perf/p5332-multi-pack-reuse.sh       |  81 ++++++++
 t/t5319-multi-pack-index.sh            | 140 +++++++++++++
 t/t5331-pack-objects-stdin.sh          | 156 +++++++++++++++
 t/t5332-multi-pack-reuse.sh            | 219 ++++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh     |   2 +
 t/t7700-repack.sh                      |   4 +-
 t/t7705-repack-extend-disjoint.sh      | 142 +++++++++++++
 t/test-lib-functions.sh                |  14 ++
 25 files changed, 1650 insertions(+), 144 deletions(-)
 create mode 100644 t/lib-disjoint.sh
 create mode 100755 t/perf/p5332-multi-pack-reuse.sh
 create mode 100755 t/t5332-multi-pack-reuse.sh
 create mode 100755 t/t7705-repack-extend-disjoint.sh


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
2.43.0.24.g980b318f98
