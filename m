From: Karsten Blees <karsten.blees@gmail.com>
Subject: Git-status / preload_index() performance
Date: Wed, 25 Jun 2014 00:52:25 +0200
Message-ID: <53AA0129.1080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzZZp-0000lI-IA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 00:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbaFXWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 18:52:28 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53616 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbaFXWw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 18:52:27 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so1533249wib.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=w/VWIUOLrV5mrdT4BSnrXm5sSJEMRbPZ7jCBh3LVsTk=;
        b=u2ZFkrmobWSDvUsed6ce+8qE8wvrcJpNl6BU+kDXZLAlG0uK2GM9Cgmi82XkaOQz8A
         8O3X/HECnN8fsE/67oQWIRnpNZeig7BaSz22DRdYbWLoIa2GHZmXVIx+QsdvrOHdMCTY
         7uZkY4d6L7CS+58OHcxdnjN/VLtBC3d+/F++Qoqjb+KTkysZx4j/RFv8ywpQWNbnCszh
         TVRWnUeeUDiLCRShCHpJWg+xJWvocQAyDQEZAzuTX2Z6xFyGjpjqdF++C2qVut5nrSub
         20jeTZYOIIkF9vdDgP04a78KHBGmRNhQ92UheZClyGk8zowPpQ6kMSjEA6WzkDHkaFcS
         46Ew==
X-Received: by 10.180.99.97 with SMTP id ep1mr2317645wib.64.1403650345463;
        Tue, 24 Jun 2014 15:52:25 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o3sm5820113wix.15.2014.06.24.15.52.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 15:52:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252421>

Putting the new trace_performance functions to good use, here are a few observations about git-status performance.

Comes with three patches (mostly independent, not a patch series!):

 * [PATCH] preload-index: optimize for sequential IO
   Improves preload-index performance, should apply anywhere.

 * [PATCH (experimental)] preload-index: make parallel IO configurable
   For anyone who'd like to play around with different parallel IO settings. Applies on top of the first patch.

 * [PATCH (performance tracing)] test git-status performance
   Used to generate the measurements at the bottom, applies on top of the performance tracing topic, e.g. pu.


Here's a rough break down of overall 'git-status -uno' performance (hot cache, preloadIndex, single HD) (see measurements [D] and [F] below):

	20% (~95 ms)  parse options and config files
  20% (~95 ms)  preload index
  55% (~275 ms) unpack HEAD tree

What surprised me was that we spend a lot of time parsing options and config files. Tanay's current config-cache topic may fix this (haven't checked though).

Even more time is spent unpacking the HEAD tree, even with hot cache (repacking with depth 10 reduces this to ~250ms, on SSD its just 7ms). Perhaps caching the HEAD tree in an index extension could help here?


Looking at preload_index() in more detail revealed that the background threads don't really run in parallel. In the cold cache case [C], some threads finish >10 s earlier than the last one. In the hot cache case [D], the last thread starts long after the first has finished (average thread run time is 25 ms, but the whole thing takes >100 ms). This is fixed in the first patch (although with hot cache, some threads exit immediately without doing anything, so starting 20 threads seems to be slower than lstat()ing 200k files).

Another issue with preload_index() in the cold cache case is the IO pattern. File systems are typically organized by directories, as is git's index. Reading from up to 20 different locations in parallel isn't exactly optimal, thus preload_index() with cold cache [C] is actually slower than lstat()ing the files sequentially in refresh_index() [A]. This is also fixed in the first patch.

The second patch makes parallel IO configurable (independent of the thread count), in case anyone is eager to play around with this (I got best results with PARALLEL_IO == 1, i.e. the same as what the first patch does).


Btw, I got similar results on Windows (just a tad slower). However, the current fscache implementation sucks with multi-threaded sequential directory scans. This is fixed in https://github.com/msysgit/git/pull/205

Cheers,
Karsten


=== Measurements ===

Test environment:
- Debian Linux
- Core i7 960 @2.8 GHz (quad core HT)
- WD VelociRaptor 300G
- WebKit, compressed with depth 50
- GIT_TRACE_PERFORMANCE=1 git status -s -uno

--- A. cold cache, preloadIndex = false ---
21:48:51.846358 builtin/commit.c:1374   performance: 0.373945122 s: cmd_status:setup
21:48:51.847107 preload-index.c:115     performance: 0.000000970 s: read_index_preload
21:49:17.464247 read-cache.c:1226       performance: 25.616986865 s: refresh_index
21:49:17.467816 builtin/commit.c:1385   performance: 0.003506054 s: cmd_status:update_index
21:49:17.479184 wt-status.c:630         performance: 0.005727824 s: wt_status_collect_changes_worktree
21:49:26.887034 wt-status.c:638         performance: 9.407759653 s: wt_status_collect_changes_index
21:49:26.887183 wt-status.c:643         performance: 0.000002555 s: wt_status_collect_untracked
21:49:26.887274 trace.c:414             performance: 35.438535209 s: git command: 'git' 'status' '-s' '-uno'

--- B. hot cache, preloadIndex = false ---
21:50:06.756099 builtin/commit.c:1374   performance: 0.096772167 s: cmd_status:setup
21:50:06.756294 preload-index.c:115     performance: 0.000000842 s: read_index_preload
21:50:07.009081 read-cache.c:1226       performance: 0.252756680 s: refresh_index
21:50:07.012212 builtin/commit.c:1385   performance: 0.002993493 s: cmd_status:update_index
21:50:07.017863 wt-status.c:630         performance: 0.005366752 s: wt_status_collect_changes_worktree
21:50:07.304434 wt-status.c:638         performance: 0.286400219 s: wt_status_collect_changes_index
21:50:07.304506 wt-status.c:643         performance: 0.000002140 s: wt_status_collect_untracked
21:50:07.304562 trace.c:414             performance: 0.645498343 s: git command: 'git' 'status' '-s' '-uno'

--- C. cold cache, preloadIndex = true (original) ---
21:37:56.446451 builtin/commit.c:1374   performance: 0.370568378 s: cmd_status:setup
21:38:13.742558 preload-index.c:68      performance: 17.294946043 s: preload_thread
21:38:18.271304 preload-index.c:68      performance: 21.822004315 s: preload_thread
21:38:18.675936 preload-index.c:68      performance: 22.226297259 s: preload_thread
21:38:19.631832 preload-index.c:68      performance: 23.182681753 s: preload_thread
21:38:19.647241 preload-index.c:68      performance: 23.197129488 s: preload_thread
21:38:20.706758 preload-index.c:68      performance: 24.258704977 s: preload_thread
21:38:20.716336 preload-index.c:68      performance: 24.267554747 s: preload_thread
21:38:21.360835 preload-index.c:68      performance: 24.912336936 s: preload_thread
21:38:21.950539 preload-index.c:68      performance: 25.501558541 s: preload_thread
21:38:22.303187 preload-index.c:68      performance: 25.855297857 s: preload_thread
21:38:22.401046 preload-index.c:68      performance: 25.953550575 s: preload_thread
21:38:22.900621 preload-index.c:68      performance: 26.450856089 s: preload_thread
21:38:23.152811 preload-index.c:68      performance: 26.705084749 s: preload_thread
21:38:23.798287 preload-index.c:68      performance: 27.348779464 s: preload_thread
21:38:23.902508 preload-index.c:68      performance: 27.454145935 s: preload_thread
21:38:24.105539 preload-index.c:68      performance: 27.655335680 s: preload_thread
21:38:24.224639 preload-index.c:68      performance: 27.774589132 s: preload_thread
21:38:24.308084 preload-index.c:68      performance: 27.859839181 s: preload_thread
21:38:24.696634 preload-index.c:68      performance: 28.246249590 s: preload_thread
21:38:25.126601 preload-index.c:68      performance: 28.676157964 s: preload_thread
21:38:25.126910 preload-index.c:115     performance: 28.679619307 s: read_index_preload
21:38:25.135398 read-cache.c:1226       performance: 0.008454608 s: refresh_index
21:38:25.138316 builtin/commit.c:1385   performance: 0.002882190 s: cmd_status:update_index
21:38:25.158006 wt-status.c:630         performance: 0.006232814 s: wt_status_collect_changes_worktree
21:38:34.540506 wt-status.c:638         performance: 9.382413445 s: wt_status_collect_changes_index
21:38:34.540656 wt-status.c:643         performance: 0.000002382 s: wt_status_collect_untracked
21:38:34.540718 trace.c:414             performance: 38.488630426 s: git command: 'git' 'status' '-s' '-uno'

--- D. hot cache, preloadIndex = true (original) ---
21:42:00.212503 builtin/commit.c:1374   performance: 0.095433165 s: cmd_status:setup
21:42:00.228933 preload-index.c:68      performance: 0.015721331 s: preload_thread
21:42:00.231618 preload-index.c:68      performance: 0.018584533 s: preload_thread
21:42:00.240873 preload-index.c:68      performance: 0.028002477 s: preload_thread
21:42:00.243997 preload-index.c:68      performance: 0.030051421 s: preload_thread
21:42:00.247607 preload-index.c:68      performance: 0.033567965 s: preload_thread
21:42:00.254185 preload-index.c:68      performance: 0.015472710 s: preload_thread
21:42:00.256297 preload-index.c:68      performance: 0.041539430 s: preload_thread
21:42:00.258719 preload-index.c:68      performance: 0.015969134 s: preload_thread
21:42:00.266561 preload-index.c:68      performance: 0.019649941 s: preload_thread
21:42:00.268836 preload-index.c:68      performance: 0.050104808 s: preload_thread
21:42:00.276642 preload-index.c:68      performance: 0.017524942 s: preload_thread
21:42:00.286878 preload-index.c:68      performance: 0.029321929 s: preload_thread
21:42:00.287704 preload-index.c:68      performance: 0.032922849 s: preload_thread
21:42:00.290427 preload-index.c:68      performance: 0.023335902 s: preload_thread
21:42:00.299536 preload-index.c:68      performance: 0.030398197 s: preload_thread
21:42:00.300145 preload-index.c:68      performance: 0.023044898 s: preload_thread
21:42:00.305255 preload-index.c:68      performance: 0.014311763 s: preload_thread
21:42:00.305593 preload-index.c:68      performance: 0.018377127 s: preload_thread
21:42:00.313995 preload-index.c:68      performance: 0.026190281 s: preload_thread
21:42:00.316405 preload-index.c:68      performance: 0.016561475 s: preload_thread
21:42:00.316610 preload-index.c:115     performance: 0.103935355 s: read_index_preload
21:42:00.324869 read-cache.c:1226       performance: 0.008188349 s: refresh_index
21:42:00.327998 builtin/commit.c:1385   performance: 0.003042783 s: cmd_status:update_index
21:42:00.333993 wt-status.c:630         performance: 0.005798696 s: wt_status_collect_changes_worktree
21:42:00.611613 wt-status.c:638         performance: 0.277536014 s: wt_status_collect_changes_index
21:42:00.611687 wt-status.c:643         performance: 0.000002299 s: wt_status_collect_untracked
21:42:00.611747 trace.c:414             performance: 0.494946405 s: git command: 'git' 'status' '-s' '-uno'

--- E. cold cache, preloadIndex = true (patched) ---
22:06:56.232746 builtin/commit.c:1374   performance: 0.370093911 s: cmd_status:setup
22:07:16.102354 preload-index.c:82      performance: 19.867838450 s: preload_thread
22:07:16.104169 preload-index.c:82      performance: 19.868153951 s: preload_thread
22:07:16.137857 preload-index.c:82      performance: 19.902306388 s: preload_thread
22:07:16.182094 preload-index.c:82      performance: 19.946227999 s: preload_thread
22:07:16.192515 preload-index.c:82      performance: 19.958357027 s: preload_thread
22:07:16.230063 preload-index.c:82      performance: 19.993785729 s: preload_thread
22:07:16.326531 preload-index.c:82      performance: 20.089808984 s: preload_thread
22:07:16.487604 preload-index.c:82      performance: 20.250688054 s: preload_thread
22:07:16.528616 preload-index.c:82      performance: 20.291710330 s: preload_thread
22:07:16.830113 preload-index.c:82      performance: 20.595193324 s: preload_thread
22:07:16.832527 preload-index.c:82      performance: 20.596083545 s: preload_thread
22:07:16.878497 preload-index.c:82      performance: 20.644448670 s: preload_thread
22:07:16.898969 preload-index.c:82      performance: 20.665179069 s: preload_thread
22:07:16.903966 preload-index.c:82      performance: 20.668675830 s: preload_thread
22:07:17.037309 preload-index.c:82      performance: 20.802909352 s: preload_thread
22:07:17.043825 preload-index.c:82      performance: 20.808079794 s: preload_thread
22:07:17.161141 preload-index.c:82      performance: 20.924512208 s: preload_thread
22:07:17.164327 preload-index.c:82      performance: 20.929630917 s: preload_thread
22:07:17.283316 preload-index.c:82      performance: 21.048249962 s: preload_thread
22:07:17.292629 preload-index.c:82      performance: 21.058296484 s: preload_thread
22:07:17.292911 preload-index.c:129     performance: 21.059322236 s: read_index_preload
22:07:17.301043 read-cache.c:1226       performance: 0.008095191 s: refresh_index
22:07:17.304204 builtin/commit.c:1385   performance: 0.003102772 s: cmd_status:update_index
22:07:17.317878 wt-status.c:630         performance: 0.006060805 s: wt_status_collect_changes_worktree
22:07:26.727669 wt-status.c:638         performance: 9.409656793 s: wt_status_collect_changes_index
22:07:26.727787 wt-status.c:643         performance: 0.000000702 s: wt_status_collect_untracked
22:07:26.727857 trace.c:414             performance: 30.895639461 s: git command: 'git' 'status' '-s' '-uno'

--- F. hot cache, preloadIndex = true (patched) ---
22:09:39.808807 builtin/commit.c:1374   performance: 0.093074742 s: cmd_status:setup
22:09:39.893509 preload-index.c:82      performance: 0.069421408 s: preload_thread
22:09:39.893543 preload-index.c:82      performance: 0.066854806 s: preload_thread
22:09:39.893781 preload-index.c:82      performance: 0.083687605 s: preload_thread
22:09:39.894532 preload-index.c:82      performance: 0.000000567 s: preload_thread
22:09:39.894559 preload-index.c:82      performance: 0.083802495 s: preload_thread
22:09:39.894662 preload-index.c:82      performance: 0.085355973 s: preload_thread
22:09:39.894741 preload-index.c:82      performance: 0.031963269 s: preload_thread
22:09:39.894919 preload-index.c:82      performance: 0.085751616 s: preload_thread
22:09:39.895119 preload-index.c:82      performance: 0.048522415 s: preload_thread
22:09:39.895183 preload-index.c:82      performance: 0.040487646 s: preload_thread
22:09:39.895522 preload-index.c:82      performance: 0.000000596 s: preload_thread
22:09:39.894037 preload-index.c:82      performance: 0.083306108 s: preload_thread
22:09:39.894156 preload-index.c:82      performance: 0.084544605 s: preload_thread
22:09:39.894170 preload-index.c:82      performance: 0.000000574 s: preload_thread
22:09:39.894106 preload-index.c:82      performance: 0.084106288 s: preload_thread
22:09:39.896097 preload-index.c:82      performance: 0.000000714 s: preload_thread
22:09:39.896301 preload-index.c:82      performance: 0.000000579 s: preload_thread
22:09:39.896470 preload-index.c:82      performance: 0.000000608 s: preload_thread
22:09:39.896574 preload-index.c:82      performance: 0.000000539 s: preload_thread
22:09:39.896753 preload-index.c:82      performance: 0.000000567 s: preload_thread
22:09:39.897054 preload-index.c:129     performance: 0.088090726 s: read_index_preload
22:09:39.905003 read-cache.c:1226       performance: 0.007922587 s: refresh_index
22:09:39.908375 builtin/commit.c:1385   performance: 0.003327374 s: cmd_status:update_index
22:09:39.913895 wt-status.c:630         performance: 0.005345165 s: wt_status_collect_changes_worktree
22:09:40.189196 wt-status.c:638         performance: 0.275230521 s: wt_status_collect_changes_index
22:09:40.189339 wt-status.c:643         performance: 0.000000635 s: wt_status_collect_untracked
22:09:40.189420 trace.c:414             performance: 0.473908455 s: git command: 'git' 'status' '-s' '-uno'
