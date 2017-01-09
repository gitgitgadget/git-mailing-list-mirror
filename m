Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C3F1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbdAIPvJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 10:51:09 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:22076 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760326AbdAIPup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 10:50:45 -0500
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v09FobiU027085
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 9 Jan 2017 15:50:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v09Fob0a004241
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 9 Jan 2017 15:50:37 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v09FoaNd013102;
        Mon, 9 Jan 2017 15:50:36 GMT
Received: from localhost (/10.175.238.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jan 2017 07:50:35 -0800
Date:   Mon, 9 Jan 2017 16:55:37 +0100
From:   Quentin Casasnovas <quentin.casasnovas@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Refreshing index timestamps without reading content
Message-ID: <20170109155537.GG7000@chrystal.oracle.com>
References: <20170105112359.GN8116@chrystal.oracle.com>
 <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
 <xmqqr34cuvjj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline
In-Reply-To: <xmqqr34cuvjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2017 at 07:01:36AM -0800, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Thu, Jan 5, 2017 at 6:23 PM, Quentin Casasnovas
> > <quentin.casasnovas@oracle.com> wrote:
> >> Is there any way to tell git, after the git ls-tree command above, to
> >> refresh its stat cache information and trust us that the file content has
> >> not changed, as to avoid any useless file read (though it will obviously
> >> will have to stat all of them, but that's not something we can really
> >> avoid)
> >
> > I don't think there's any way to do that, unfortunately.
>
> Lose "unfortunately".
>
> >> If not, I am willing to implement a --assume-content-unchanged to the git
> >> update-index if you guys don't see something fundamentally wrong with this
> >> approach.
> >
> > If you do that, I think you should go with either of the following options
> >
> > - Extend git-update-index --index-info to take stat info as well (or
> > maybe make a new option instead). Then you can feed stat info directly
> > to git without a use-case-specific "assume-content-unchanged".
> >
> > - Add "git update-index --touch" that does what "touch" does. In this
> > case, it blindly updates stat info to latest. But like touch, we can
> > also specify  mtime from command line if we need to. It's a bit less
> > generic than the above option, but easier to use.
>
> Even if we assume that it is a good idea to let people muck with the
> index like this, either of the above would be a usable addition,
> because the cached stat information does not consist solely of
> mtime.
>
> "git update-index --index-info" was invented for the case where a
> user or a script _knows_ the object ID of the blob that _would_
> result if a contents of a file on the filesystem were run through
> hash-object.  So from the interface's point of view, it may make
> sense to teach it to take an extra/optional argument that is the
> path to the file and take the stat info out of the named file when
> the extra/optional argument was given.
>
> But that assumes that it is a good idea to do this in the first
> place.  It was deliberate design decision that setting the cached
> stat info for the entry was protected behind actual content
> comparison, and removing that protection will open the index to
> abuse.
>

Hi Junio,

Thanks for your feedback, appreciated :)

I do understand how it would be possible for someone to shoot themselves in
the feet with such option, but it solves real life use cases and improved
build times very signficantly here.

Another use case we have is setting up very lightweight linux work trees,
by reflinking from a base work-tree.  This allows for a completely
different work-tree taking up almost no size at first, whereas using a
shared clone or the recent worktree subcommand would "waste" ~500MB*:

 # linux-2.6 is a shared clone of a bare clone residing locally
 ~ $ cp --reflink -a linux-2.6 linux-2.6-reflinked

 # At this point, the mtime inside linux-2.6-reflinked are matching the
 # mtime of the source linux-2.6 (since we used the '-a' option of 'cp)
 ~ $ diff -u <(stat linux-2.6/README) <(stat linux-2.6-reflinked/README)
 --- /proc/self/fd/11  2017-01-09 16:34:04.523438942 +0100
 +++ /proc/self/fd/12  2017-01-09 16:34:04.523438942 +0100
 @@ -1,8 +1,8 @@
 -  File: 'linux-2.6/README'
 +  File: 'linux-2.6-reflinked/README'
    Size: 18372		Blocks: 40         IO Block: 4096   regular file
 -Device: fd00h/64768d	Inode: 268467090   Links: 1
 +Device: fd00h/64768d	Inode: 805970606   Links: 1
  Access: (0644/-rw-r--r--)  Uid: ( 1000/ quentin)   Gid: ( 1000/ quentin)
  Access: 2017-01-09 12:04:15.317758718 +0100
  Modify: 2017-01-09 12:04:12.566758772 +0100
 -Change: 2017-01-09 12:04:12.566758772 +0100
 +Change: 2017-01-09 16:29:48.305444003 +0100
   Birth:

  # Now let's check how long it takes to refresh the index from the source
  # and destination..
  ~/linux-2.6 $ time git update-index --refresh
  git update-index --refresh  0.04s user 0.08s system 204% cpu 0.058 total
                                                               ~~~~~~~~~~~
  ~/linux-2.6-reflinked $ time git update-index --refresh
  git update-index --refresh  2.40s user 1.43s system 38% cpu 10.003 total
                                                              ~~~~~~~~~~~~

This is quite a high penalty when a power user knows that his lightweight
copy worktree matches the index!  That's on a single worktree on a fairly
decent SSD but our build farm would do this with hundreds of work trees in
parallel, all residing on a spinning disks - the penalty would be much
worse than 10 seconds wasted.

I might have a look at adding reflinking awareness to the worktree
subcommand (if it hasn't been implemented already) to avoid this index
force refreshing but that still would not fix our other use case where we
knowingly change the mtime of the files on our worktrees.

* That's a rather low estimate:

  git ls-tree -zr --name-only v4.9 | du -csh --files0-from=- | tail -n1
  747M  total

> The userbase of Git has grown wide enough that it is harder to say "If
> you lie that a file whose contents does not match the index is up to date
> using this mechanism, you will lose data and all bad things happen---you
> can keep both halves".  Once we release a version of Git with such a
> "feature", the first bug report will be "I did not want to run
> 'update-index --refresh' because it takes time, and some index entries
> apparently did not match what is on the filesystem, and I got a corrupt
> working file after a merge.  Git should make sure that the contents match
> when using the new 'path to the file' argument when updating the cached
> stat info!".  I do not have a good answer to such a bug report.
>

The good answer would probably be that this is intended behaviour and would
explicitly be mentionned in the manual for that specific option?  :)

How about renaming the option (which is more of a sub-command) to
--i-know-this-can-eat-my-data-but-refresh-stat-only?  Then we can print a
big warning saying this is generally a VERY bad idea?

Q

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYc7JsAAoJEB5Tt01po9cN2xIQAJhU31j1GuK8FrUhe0U8UA8l
Q48kXtTvVrCX6tHLVusAxXfL3C/rB43/aepBT06qMVVhyKlqMXh91a4g5U4q/rTL
ZhL/ztWacT8Sdd3UycTc8BxY38izigCGsV1rgMRRNqYJyeovJQIZqQZGCDy0SR1i
sBMOmJxXyMp0l5ZSgQltCMEgDrH8MeBADQJJ/REhQ598tMui9hf+wFa2MbF/rAUI
xD20Xe180FVvEE9npFW5sq6+v8EgonI0nsQ/o8v888C9FoAbmdC+A4NZd8GkNS6P
jlqhPZ+IJLDC0NlIECgcxUWpXUBHjK+mNcwsJBqfso4iEXSpajNiuf4K6skIjfdl
htp+cx9VHxFoEM+SghmeKeCTAJDEOeW0LAPyeksL75hgyKzxlm/LRcN3Eelio6uA
W6CidhfRBMC07EDRSFB9DJXznk+6mvfwGQ7QrancfuNORFldTyGwprHjA2EK5dlK
En1ICOcUBJ66L5XR//ZZ23bO7fdYwlEHuKxYJusl3UixCBa/hJ0BJ+X2ScsLV+0F
GVzSM4bFd7SADPlCsliCgav/k5x2PEbsoyp/sLNOpyH+gg4kZENYOMwiLHRyo/43
I4q2rSiVPdLL/9K4dectpWRfCm9hlfdlM4PuL4W6XzeBp+scItHhEInAUdNkhl9L
c9JOR+ZsyjGKLwx+5FN/
=M/uw
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--
