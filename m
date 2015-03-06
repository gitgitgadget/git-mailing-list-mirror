From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Why is "git fetch --prune" so much slower than "git remote prune"?
Date: Fri, 6 Mar 2015 17:48:39 +0100
Message-ID: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:49:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTvR0-0003tK-2u
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbbCFQtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:49:02 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38378 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbbCFQtA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 11:49:00 -0500
Received: by obcwo20 with SMTP id wo20so21732219obc.5
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 08:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=X3ersejABmK6PaPFxcvyph6pP5ZocHbRrx+hbPjORrQ=;
        b=O33MJAMILlOn0iBsnPPvgMoYC2xjLNrIlnhK5CXsy2NSU8gGYYDZ4aJdSKkCGTXTGC
         viApwb688IXR80Uw+hyMsYAtYhyaW1oFH5eWvpEPRP7rHkJtoO/GbST+Py/8P7QNiTWG
         u7FlDjdO8c5DOX3qFFjd7laGDiy4AYOiLmmZxHIesCzQHFCKA2m8yaSKktyLmOvJbf1C
         Zfx4giQv1c4RLnFpuNxYUWB3Z3xzzVHmTHv/6RcbjqHhaJdQ4L+665v7VoAFA5ZCDraZ
         zPWxDz1DYVMUSAQHe3TrLTbR/zx9PcDURnfghzXJKEfKNig9n60rcN0VzVQnxg8RIejI
         sIIQ==
X-Received: by 10.182.60.197 with SMTP id j5mr11544856obr.85.1425660539981;
 Fri, 06 Mar 2015 08:48:59 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Fri, 6 Mar 2015 08:48:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264941>

The --prune option to fetch added in v1.6.5-8-gf360d84 seems to be
around 20-30x slower than the equivalent operation with git remote
prune. I'm wondering if I'm missing something and fetch does something
more, but it doesn't seem so.

To test this clone git.git, create 1000 branches it in, create two
local clones of that clone and then delete the 1000 branches in the
original. I have a script to do this at
https://gist.github.com/avar/497c8c8fbd641fb756ef

Then in each of the clones:

    $ git branch -a|wc -l; time (~/g/git/git-fetch --prune origin
>/dev/null 2>&1); git branch -a | wc -l
1003
    real    0m3.337s
    user    0m2.996s
    sys     0m0.336s
    3

    $ git branch -a|wc -l; time (~/g/git/git-remote prune origin
>/dev/null 2>&1); git branch -a | wc -l
    1003
    real    0m0.067s
    user    0m0.020s
    sys     0m0.040s
    3

Both of these ends up doing a "git fetch", so it's not that. I'm quite
rusty in C profiling but here's a gprof of the git-fetch command:

$ gprof ~/g/git/git-fetch|head -n 20
Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls   s/call   s/call  name
 26.42      0.33     0.33  1584583     0.00     0.00  strbuf_getwholeline
 14.63      0.51     0.18 90601347     0.00     0.00  strbuf_grow
 13.82      0.68     0.17  1045676     0.00     0.00  find_pack_entry_one
  8.13      0.78     0.10  1050062     0.00     0.00  check_refname_format
  6.50      0.86     0.08  1584675     0.00     0.00  get_sha1_hex
  5.69      0.93     0.07  2100529     0.00     0.00  starts_with
  3.25      0.97     0.04  1044043     0.00     0.00  refname_is_safe
  3.25      1.01     0.04     8007     0.00     0.00  get_packed_ref_cache
  2.44      1.04     0.03  2605595     0.00     0.00  search_ref_dir
  2.44      1.07     0.03  1040500     0.00     0.00  peel_entry
  1.63      1.09     0.02  2632661     0.00     0.00  get_ref_dir
  1.63      1.11     0.02  1044043     0.00     0.00  create_ref_entry
  1.63      1.13     0.02     8024     0.00     0.00  do_for_each_entry_in_dir
  0.81      1.14     0.01  2155105     0.00     0.00  memory_limit_check
  0.81      1.15     0.01  1580503     0.00     0.00  sha1_to_hex

And of the git-remote command:

$ gprof ~/g/git/git-remote|head -n 20
Flat profile:

Each sample counts as 0.01 seconds.
 no time accumulated

  %   cumulative   self              self     total
 time   seconds   seconds    calls  Ts/call  Ts/call  name
  0.00      0.00     0.00   197475     0.00     0.00  strbuf_grow
  0.00      0.00     0.00    24214     0.00     0.00  sort_ref_dir
  0.00      0.00     0.00    24190     0.00     0.00  search_ref_dir
  0.00      0.00     0.00    21661     0.00     0.00  memory_limit_check
  0.00      0.00     0.00    20236     0.00     0.00  get_ref_dir
  0.00      0.00     0.00     9187     0.00     0.00  xrealloc
  0.00      0.00     0.00     7048     0.00     0.00  strbuf_add
  0.00      0.00     0.00     6348     0.00     0.00  do_xmalloc
  0.00      0.00     0.00     6126     0.00     0.00  xcalloc
  0.00      0.00     0.00     6056     0.00     0.00  cleanup_path
  0.00      0.00     0.00     6050     0.00     0.00  get_git_dir
  0.00      0.00     0.00     6050     0.00     0.00  vsnpath
  0.00      0.00     0.00     5554     0.00     0.00  config_file_fgetc

Aside from the slowness of git-fetch it seems git-remote can be sped
up quite a bit by more aggressively allocating a larger string buffer
from the get-go.
