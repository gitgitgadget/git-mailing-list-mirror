From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except
 in resolve_symlink)
Date: Wed, 3 Sep 2014 01:00:21 -0700 (PDT)
Message-ID: <1409731221311-7617967.post@n2.nabble.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com> <1405858399-23082-1-git-send-email-pclouds@gmail.com> <1406814214-21725-1-git-send-email-pclouds@gmail.com> <1406814214-21725-2-git-send-email-pclouds@gmail.com> <xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com> <xmqqtx5wuma8.fsf@gitster.dls.corp.google.com> <53DD2A54.1030403@web.de> <CACsJy8BAB3n5BRVaveTBrhdSDpiPBtm==TRjiv4ZR2P6iMne_w@mail.gmail.com> <53E101F0.5090408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 10:00:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP5US-00065x-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 10:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbaICIAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 04:00:23 -0400
Received: from sam.nabble.com ([216.139.236.26]:54896 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbaICIAW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 04:00:22 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1XP5UL-0000Sa-AN
	for git@vger.kernel.org; Wed, 03 Sep 2014 01:00:21 -0700
In-Reply-To: <53E101F0.5090408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256383>

Hi Michael:

> On 08/04/2014 03:13 AM, Duy Nguyen wrote:
>
>> On Sun, Aug 3, 2014 at 1:13 AM, Torsten B=C3=B6gershausen <[hidden e=
mail]>
>> wrote:=20
>> [...]=20
>>> My first impression reading this patch was to rename=20
>>> clear_filename() into free_and_clear_filename() or better
>>> free_filename(),=20
>>> but I never pressed the send button ;-)=20
>>>=20
>>> Reading the discussion above makes me wonder if lk->filename may be
>>> replaced=20
>>> by a strbuf=20
>>> some day, and in this case clear_filename() will become reset_filen=
mae()
>>> ?=20
>>=20
>> I didn't realize Mike is making a lot more changes in lockfile.c, pa=
rt=20
>> of that is converting lk->filename to use strbuf [1]. Perhaps I shou=
ld=20
>> just withdraw this series, wait until Mike's series is merged, then=20
>> redo 3/3 on top. Or Mike could just take 3/3 in as part of his serie=
s.=20
>>=20
>> [1]
>> http://thread.gmane.org/gmane.comp.version-control.git/246222/focus=3D=
246232
>=20
> I've neglected my patch series for ages (sorry!)  The last round of=20
> review pointed out a couple of places where lock_file objects were st=
ill=20
> being left in undefined states, and since then it also bit-rotted.=20
>=20
> Over the past few days I re-rolled the patch series and fixed some mo=
re=20
> code paths.  I still want to check it over before submitting it to th=
e=20
> list, but if you are interested the current version is here [1].=20
>=20
> Duy, I'll try to look at your patches, but probably won't get to it=20
> until next week when I return from vacation.=20
>=20
> Michael=20
>=20
> [1] https://github.com/mhagger/git branch "lock-correctness"=20

=E2=80=8BI am tracing the lock path issue.
(http://git.661346.n2.nabble.com/git-update-index-not-delete-lock-file-=
when-using-different-worktree-td7615300.html)

and I see mh/lockfile part in=20
http://git.661346.n2.nabble.com/What-s-cooking-in-git-git-Sep-2014-01-T=
ue-2-td7617955.html
as following:

* mh/lockfile (2014-04-15) 25 commits
 . trim_last_path_elm(): replace last_path_elm()
 . resolve_symlink(): take a strbuf parameter
 . resolve_symlink(): use a strbuf for internal scratch space
 . change lock_file::filename into a strbuf
 . commit_lock_file(): use a strbuf to manage temporary space
 . try_merge_strategy(): use a statically-allocated lock_file object
 . try_merge_strategy(): remove redundant lock_file allocation
 . struct lock_file: declare some fields volatile
 . lockfile: avoid transitory invalid states
 . commit_lock_file(): die() if called for unlocked lockfile object
 . commit_lock_file(): inline temporary variable
 . remove_lock_file(): call rollback_lock_file()
 . lock_file(): exit early if lockfile cannot be opened
 . write_packed_entry_fn(): convert cb_data into a (const int *)
 . prepare_index(): declare return value to be (const char *)
 . delete_ref_loose(): don't muck around in the lock_file's filename
 . cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 . lockfile.c: document the various states of lock_file objects
 . lock_file(): always add lock_file object to lock_file_list
 . hold_lock_file_for_append(): release lock on errors
 . lockfile: unlock file if lockfile permissions cannot be adjusted
 . rollback_lock_file(): set fd to -1
 . rollback_lock_file(): do not clear filename redundantly
 . api-lockfile: expand the documentation
 . unable_to_lock_die(): rename function from unable_to_lock_index_die(=
)

 Expecting a reroll.

So, do you have any plan about mh/lockfile and the lock path issue?

Thank you.=E2=80=8B ^_^

Yue Lin Ho



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-Mak=
e-locked-paths-absolute-when-current-directory-is-changed-tp7615398p761=
7967.html
Sent from the git mailing list archive at Nabble.com.
