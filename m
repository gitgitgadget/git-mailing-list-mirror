From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 3/4] pack-objects: don't traverse objects unnecessarily
Date: Sun, 13 Nov 2011 16:34:04 -0600
Message-ID: <CAEik5nPJ3r6gp9Lttzh5aQmiPRFxpZvhTBXZoreY98QV6Cocdg@mail.gmail.com>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
	<1318915284-6361-3-git-send-email-dpmcgee@gmail.com>
	<7vk47qxe9x.fsf@alter.siamese.dyndns.org>
	<CAEik5nNmAnPni+rnLm7n5tO7f=LV_1TuTbVqxgjVaoqqaF_Ukw@mail.gmail.com>
	<7v1utdrfsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 23:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPicy-0000Vx-Ok
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 23:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab1KMWeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 17:34:08 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36628 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1KMWeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 17:34:06 -0500
Received: by bke11 with SMTP id 11so5252765bke.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 14:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0vICj/K+V7AbY1U468Kk6TKfZ+wQzHLxXoK6b/bgnzQ=;
        b=wwH9n+UYFqKdKYtv0Ha3Zo6YvqhKUMrhqp8tV+CNYbMGnu9pXsVMdGFhJesvLyRYoF
         ctKeXGKZo7CQmr3gPEMGkeDve3N409IS67aDp8mSsGDuxsyofoiyrqsUPaRakh99WwSb
         fTDv9lZipobWkCO+TQgGU8HepWDny6bCZyLdg=
Received: by 10.205.132.69 with SMTP id ht5mr8841001bkc.115.1321223645054;
 Sun, 13 Nov 2011 14:34:05 -0800 (PST)
Received: by 10.205.81.76 with HTTP; Sun, 13 Nov 2011 14:34:04 -0800 (PST)
In-Reply-To: <7v1utdrfsf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185352>

On Sat, Nov 12, 2011 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> On Thu, Oct 27, 2011 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> I am not sure if this produces the identical result that was benchmarked
>>> in the original series.
>> I was not either when I wrote the patch, and I had hoped to confirm
>> the results you showed in the message of 1b4bb16b9ec.
>
> I actually am reasonably sure the result will not be identical, but I also
> do not think it matters. The differences would appear only for entries
> that have been filled earlier, which should be a minority.
>
>> unable to figure out how you generated those numbers so I wasn't able
>> to do so (and had planned to get back to you to find out how you made
>> those tables). Were you able to verify the ordering did not regress?
>
> No; I was hoping you would redo the benchmark using 5f44324 (core: log
> offset pack data accesses happened, 2011-07-06).

I'm still not sure what you used to parse these results, so I had to
spend a good amount of time writing up scripts to parse that output.
Anyway, I ran tests that nearly correspond to the ones you quoted on
four different pack-object versions as noted below. The first is one
revision before your original changes, the next two are
self-explanatory, and the final version is with the short diff
included below.

Observations:
* Perhaps I did something wrong, but the v1.7.7.2 numbers don't seem
to agree with the figures you came up with- not sure why that is,
however, and I've already spent a lot of time on this today and don't
really have more time to sink into this.
* The diff included below seems to make a significant difference in
some of the seek values.

dmcgee@galway ~/logs-git
$ ~/projects/git/parse_pack_access.py *git_log.txt
                 1b4bb16b9ec~1          v1.7.7.2          v1.7.7.3
add-whole-family
        0.0:                32                32                32
           32
       10.0:               256               256               256
          256
       20.0:               293               293               293
          293
       30.0:               327               327               327
          327
       40.0:               366               366               366
          366
       50.0:               421               421               421
          421
       60.0:               526               526               526
          526
       70.0:               894               894               894
          895
       80.0:             11612             11625             11622
        11625
       90.0:             97405             97487             97487
        97510
       95.0:            280123            280391            280396
       280391
       99.0:           1251812           1254871           1252919
      1253318
       99.5:           1850181           1853291           1853100
      1853106
       99.9:           4008778           4013897           3988759
      4013897
   accesses:            280450            280464            280457
       280461
 <2MiB seek:             99.61             99.61             99.61
        99.61

dmcgee@galway ~/logs-git
$ ~/projects/git/parse_pack_access.py *git_log_drivers_net.txt
                 1b4bb16b9ec~1          v1.7.7.2          v1.7.7.3
add-whole-family
        0.0:                 0                 0                 0
            0
       10.0:               144                46                46
           46
       20.0:               233                48                48
           48
       30.0:               317                98                97
           97
       40.0:               512              1396              1367
          990
       50.0:              2921            773060            786210
       399996
       60.0:            774452          11594348          10156053
      4532415
       70.0:         333258049         424530065         428113049
    101687854
       80.0:         411869214         438733385         438510929
    106316734
       90.0:         426972983         444510034         443993824
    112362757
       95.0:         432061866         447253337         446466814
    116078451
       99.0:         434915514         453076229         451430514
    118597896
       99.5:         435032830         454359692         452394830
    119008652
       99.9:         435123054         456005056         454017949
    119605604
   accesses:            601405            600780            601732
       601219
 <2MiB seek:             61.68             53.06             53.53
        56.21

dmcgee@galway ~/logs-git
$ ~/projects/git/parse_pack_access.py *blame*.txt
                 1b4bb16b9ec~1          v1.7.7.2          v1.7.7.3
add-whole-family
        0.0:                 0                 0                 0
            0
       10.0:               137                46                46
           46
       20.0:               192                48                48
           48
       30.0:               309                97                97
           97
       40.0:               774              5246              5244
         4034
       50.0:             32585           2643798           2585078
      1518706
       60.0:         376168864         434624162         434479253
    102257691
       70.0:         415045893         438464313         438213313
    104681256
       80.0:         425668210         441472744         441222839
    107541644
       90.0:         430603653         445070643         444450126
    112494824
       95.0:         433514511         447215535         446450183
    116456428
       99.0:         435037297         453431874         451707047
    118722564
       99.5:         435065325         454459123         452652312
    119165598
       99.9:         435149193         456205377         454197863
    119710538
   accesses:            199249            194708            194738
       194875
 <2MiB seek:             54.31             49.25             49.43
        50.94

dmcgee@galway ~/logs-git
$ ~/projects/git/parse_pack_access.py *index*.txt
                 1b4bb16b9ec~1          v1.7.7.2          v1.7.7.3
add-whole-family
        0.0:                 9                 9                 9
            9
       10.0:               137                45                45
           45
       20.0:               224                47                47
           47
       30.0:               315                71                71
           71
       40.0:               449                96                96
           96
       50.0:               808               164               165
          165
       60.0:              2693               289               290
          287
       70.0:             46913               456               458
          448
       80.0:           1456359               966               975
          905
       90.0:          12555961              3423              3486
         2836
       95.0:          44134452             10211             10616
         7075
       99.0:         269753078         304302120         314414250
        35401
       99.5:         353346206         386205936         388585783
        59897
       99.9:         408908212         414260557         415445310
       244643
   accesses:           3050155           3045012           3045025
      3045141
 <2MiB seek:             81.56             98.71             98.65
        99.98


The scripts used, obviously some hardcoded magic here should be able
to use them if you want:

$ cat test_pack.sh
#!/bin/bash -e

versions=('1b4bb16b9ec~1' 'v1.7.7.2' 'v1.7.7.3' 'add-whole-family')
commands=('git log' 'git log drivers/net' 'git blame
drivers/net/netconsole.c' 'git index-pack -v
.git/objects/pack/*.pack')

gitdir=/home/dmcgee/projects/git
linuxdir=/home/dmcgee/projects/linux

export GIT_EXEC_DIR=$gitdir

for version in "${versions[@]}"; do
	echo $version
	cd $gitdir
	git checkout $version
	make -j6 CFLAGS="-march=native -mtune=native -O2 -pipe -g"
PYTHON_PATH=/usr/bin/python2
	cd $linuxdir
	git config core.logpackaccess "/tmp/$version-repack.txt"
	$gitdir/git repack -a -d
	for command in "${commands[@]}"; do
		clean_cmd=${command//\//_}
		clean_cmd=${clean_cmd// /_}
		git config core.logpackaccess "/tmp/$version-$clean_cmd.txt"
		echo $command
		$gitdir/$command >/dev/null
	done
	git config --unset core.logpackaccess
done


$ cat parse_pack_access.py
#!/usr/bin/python2

from collections import defaultdict
import sys

def read_file(filename):
    packs = defaultdict(list)
    with open(filename, 'r') as data:
        for line in data.readlines():
            pack, position = line.strip().split(' ')
            packs[pack].append(int(position))
    return packs

def calculate_seeks(positions):
    seeks = []
    prev = positions[0]
    for position in positions[1:]:
        seeks.append(abs(position - prev))
        prev = position
    return sorted(seeks)

def bucket_seeks(seeks):
    percents = [0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0,
            95.0, 99.0, 99.5, 99.9]
    results = []
    for percent in percents:
        index = int(percent/100.0 * len(seeks))
        offset = seeks[index]
        results.append((percent, offset))

    return results

def print_result_line(label, results):
    print '%12s%s' % (label,
            ''.join('%18s' % result for result in results))

def main(filenames):
    known_versions = ['1b4bb16b9ec~1', 'v1.7.7.2', 'v1.7.7.3',
'add-whole-family']
    pack_accesses = {}

    for filename in filenames:
        pack_accesses[filename] = read_file(filename)

    bucket_table = defaultdict(list)
    accesses = []
    under_twomb = []
    for version in known_versions:
        filename = [fn for fn in pack_accesses.keys() if
fn.startswith(version)][0]
        access = pack_accesses[filename]

        for pack, positions in access.items():
            seeks = calculate_seeks(positions)
            results = bucket_seeks(seeks)
            for percent, offset in results:
                bucket_table[percent].append(offset)
            accesses.append(len(positions))
            under_twomb.append(sum(1 for s in seeks if s < 2 * 1024 *
1024) * 100.0 / len(seeks))

    print_result_line('', known_versions)
    for k in sorted(bucket_table.keys()):
        print_result_line('%.1f:' % k, bucket_table[k])
    print_result_line('accesses:', accesses)
    print_result_line('<2MiB seek:', ('%.2f' % under for under in under_twomb))

if __name__ == '__main__':
    main(sys.argv[1:])



>From dfee7999b95442a5de2a7a0232c75262d13a28d6 Mon Sep 17 00:00:00 2001
From: Dan McGee <dpmcgee@gmail.com>
Date: Sun, 13 Nov 2011 15:07:13 -0600
Subject: [PATCH] Add whole family when packing objects

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/pack-objects.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80ab6c3..0a9e761 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -566,7 +566,7 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (; i < nr_objects; i++) {
 		if (objects[i].tagged)
-			add_to_write_order(wo, &wo_end, &objects[i]);
+			add_family_to_write_order(wo, &wo_end, &objects[i]);
 	}

 	/*
@@ -576,7 +576,7 @@ static struct object_entry **compute_write_order(void)
 		if (objects[i].type != OBJ_COMMIT &&
 		    objects[i].type != OBJ_TAG)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_family_to_write_order(wo, &wo_end, &objects[i]);
 	}

 	/*
@@ -585,7 +585,7 @@ static struct object_entry **compute_write_order(void)
 	for (i = last_untagged; i < nr_objects; i++) {
 		if (objects[i].type != OBJ_TREE)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_family_to_write_order(wo, &wo_end, &objects[i]);
 	}

 	/*
-- 
1.7.7.3
