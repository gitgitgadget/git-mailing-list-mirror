From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: git rev-list | git cherry-pick --stdin is leaky
Date: Wed, 01 May 2013 11:27:03 -0700
Message-ID: <51815E77.8080601@codeaurora.org>
References: <517F0C18.8060703@codeaurora.org> <51804A02.6080301@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 01 20:27:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbkF-0001Zs-5M
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab3EAS1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 14:27:07 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:7543 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3EAS1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:27:05 -0400
X-IronPort-AV: E=Sophos;i="4.87,590,1363158000"; 
   d="scan'208";a="43209510"
Received: from pdmz-ns-snip_114_130.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2013 11:27:03 -0700
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id BDCE210004BF;
	Wed,  1 May 2013 11:27:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51804A02.6080301@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223111>

On 04/30/13 15:47, Ren=E9 Scharfe wrote:
> Am 30.04.2013 02:11, schrieb Stephen Boyd:
>> (resending since the attachment seems to make vger sad)
>>
>> Hi,
>>
>> I'm running git rev-list | git cherry-pick --stdin on a range of abo=
ut
>> 300 commits. Eventually the chery-pick dies with:
>>
>>      error: cannot fork() for commit: Cannot allocate memory
>>
>> Running valgrind shows me that the tree traversal code is leaking
>> gigabytes of memory (particularly unpack_callback). Since cherry-pic=
k is
>> a very long running process all these allocations are never freed an=
d
>> eventually I run out of memory. The worst offender and summary is:
>>
>> =3D=3D7986=3D=3D 938,956,692 (929,961,582 direct, 8,995,110 indirect=
) bytes in
>> 7,765,439 blocks are definitely lost in loss record 257 of 257
>> =3D=3D7986=3D=3D    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
>> =3D=3D7986=3D=3D    by 0x4FAF57: xcalloc (wrapper.c:119)
>> =3D=3D7986=3D=3D    by 0x4F5281: unpack_callback (unpack-trees.c:539=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467=
)
>> =3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
>> =3D=3D7986=3D=3D
>> =3D=3D7986=3D=3D LEAK SUMMARY:
>> =3D=3D7986=3D=3D    definitely lost: 2,514,117,692 bytes in 21,210,8=
61 blocks
>> =3D=3D7986=3D=3D    indirectly lost: 885,481,947 bytes in 10,165,801=
 blocks
>> =3D=3D7986=3D=3D      possibly lost: 650,712,395 bytes in 6,014,309 =
blocks
>> =3D=3D7986=3D=3D    still reachable: 7,734,870 bytes in 47,794 block=
s
>> =3D=3D7986=3D=3D         suppressed: 0 bytes in 0 blocks
> I looked at that particular leak a year ago but couldn't convince mys=
elf
> to submit the patch below.  If the callback function we call through
> call_unpack_fn does something strange like free()ing entries itself o=
r
> adding them to some list without duplication then the added free() ca=
n
> cause trouble.
>
> Looking at it again today I don't understand that concern any more.  =
The
> current callback functions don't do something like that, in any case.
> Maybe I'm missing something.
>
> Anyway, could you please check if the patch helps with your use case?

Ok I think I will make a copy of my .git first before I try out your
patch. In case you're curious here are the next big leaks.

=3D=3D7986=3D=3D 433,116,790 (432,950,308 direct, 166,482 indirect) byt=
es in 4,146,402 blocks are definitely lost in loss record 253 of 257
=3D=3D7986=3D=3D    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
=3D=3D7986=3D=3D    by 0x4FAF57: xcalloc (wrapper.c:119)
=3D=3D7986=3D=3D    by 0x4F5281: unpack_callback (unpack-trees.c:539)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
=3D=3D7986=3D=3D    by 0x4AD095: git_merge_trees (merge-recursive.c:241=
)
=3D=3D7986=3D=3D    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
=3D=3D7986=3D=3D    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
=3D=3D7986=3D=3D
=3D=3D7986=3D=3D 482,083,201 (46,465,928 direct, 435,617,273 indirect) =
bytes in 93 blocks are definitely lost in loss record 255 of 257
=3D=3D7986=3D=3D    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
=3D=3D7986=3D=3D    by 0x4FAF57: xcalloc (wrapper.c:119)
=3D=3D7986=3D=3D    by 0x4C4AE4: read_index_from (read-cache.c:1452)
=3D=3D7986=3D=3D    by 0x4D99BC: do_pick_commit (sequencer.c:297)
=3D=3D7986=3D=3D    by 0x4DA750: pick_commits (sequencer.c:995)
=3D=3D7986=3D=3D    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:=
1124)
=3D=3D7986=3D=3D    by 0x463E7C: cmd_cherry_pick (revert.c:236)
=3D=3D7986=3D=3D    by 0x404C86: handle_internal_command (git.c:284)
=3D=3D7986=3D=3D    by 0x40541C: main (git.c:492)
=3D=3D7986=3D=3D
=3D=3D7986=3D=3D 557,706,880 (548,062,684 direct, 9,644,196 indirect) b=
ytes in 4,931,819 blocks are definitely lost in loss record 256 of 257
=3D=3D7986=3D=3D    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
=3D=3D7986=3D=3D    by 0x4FAF57: xcalloc (wrapper.c:119)
=3D=3D7986=3D=3D    by 0x4F5281: unpack_callback (unpack-trees.c:539)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F586C: unpack_callback (unpack-trees.c:467)
=3D=3D7986=3D=3D    by 0x4F40E5: traverse_trees (tree-walk.c:407)
=3D=3D7986=3D=3D    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
=3D=3D7986=3D=3D    by 0x4AD095: git_merge_trees (merge-recursive.c:241=
)
=3D=3D7986=3D=3D

=46ull report can be found at https://gist.github.com/bebarino/5497181

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
