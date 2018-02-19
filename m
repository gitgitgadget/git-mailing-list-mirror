Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B3E1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932194AbeBSWhU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:37:20 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44681 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeBSWhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 17:37:19 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1JMbAVr027528
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Feb 2018 17:37:11 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Peter Backes'" <rtc@helen.PLASMA.Xg8.DE>
Cc:     <git@vger.kernel.org>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
In-Reply-To: <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Subject: RE: Git should preserve modification times at least on request
Date:   Mon, 19 Feb 2018 17:37:05 -0500
Message-ID: <007901d3a9d2$2edd7cd0$8c987670$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJZbTC47MKZPVAOS2Y2vuFiN4livgIFHHnzopCc/gA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 19, 2018 4:58 PM Johannes wrote:
> On Mon, 19 Feb 2018, Peter Backes wrote:
> 
> > please ensure to CC me if you reply as I am not subscribed to the list.
> >
> > https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preservi
> > ng_modification_time_on_files.3F argues that git isn't preserving
> > modification times because it needs to ensure that build tools work
> > properly.
> >
> > I agree that modification times should not be restored by default,
> > because of the principle of least astonishment. But should it be
> > impossible? The principle of least astonishment does not mandate this;
> > it is not a paternalistic principle.
> >
> > Thus, I do not get at all
> > - why git doesn't *store* modification times, perhaps by default, but
> > at least on request
> > - why git doesn't restore modification times *on request*
> >
> > It is pretty annoying that git cannot, even if I know what I am doing,
> > and explicitly want it to, preserve the modification time.
> >
> > One use case: I have lots of file lying around in my build directory
> > and for some of them, the modification time in important information
> > to me. Those files are not at all used with the build tool. In
> > contrast to git pull, git pull --rebase needs those to be stashed. But
> > after the pull and unstash, the mtime is gone. Boo.
> >
> > Please provide options to store and restore modification times. It
> > shouldn't be hard to do, given that other metadata such as the mode is
> > already stored. It would make live so much easier. And the fact that
> > this has made into the FAQ clearly suggests that there are many others
> > who think so.
> 
> Since you already assessed that it shouldn't be hard to do, you probably
> want to put your money where your mouth is and come up with a patch, and
> then offer it up for discussion on this here mailing list.

Putting my large-production-user hat on, there are (at least) three
conditions that exist in this space:

1. Build systems - this typically need the file modification time to be set
to the time at which git touches a file (e.g., checkout). This permits build
systems to detect that files are modified (even if an older version is
checked out, make, for example, still needs to see the change to initiate a
build. My understanding is that current git behaviour is modeled on this use
case.

2. Commit linkage - in some environments, files that are checked out are set
to the timestamp of the commit rather than the original file time or the
checkout time. This permits a faster production resolution of when changes
were run through the system as a group. I have implemented this strategy
(somewhat grudgingly) in a few places. It is a possible desire for some
users. I particularly dislike this approach because merge/cherry-pick/rebase
can mess with the preceptive "when" of a change and if you are going to do
this, make sure that your metadata is suitably managed.

3. Original file times - as Peter asked, storing the original file time has
some legacy advantages. This emulates the behaviour of some legacy SCM
systems and makes people feel better about things. From an audit point of
view, this has value for systems other than git. In git, you use the
hash-object to figure out what the file really is, so there is no real audit
need anymore for timestamps, which can be spoofed at whim anyway. The
hash-object comment applies to 2 also. Same comment here for dealing with
non-touching but modifying. For example: what is the timestamp on a
merge-squash? I would contend that it is the time of the merge-squash, not
the original time. It could also be an interim term, when a conflict was
resolved.

Just remember that #2 and #3 break #1, unless you essentially rebuild from
scratch in every build (ant/maven models). With that said, I seen many repo
admins who want all of the above, so making them all available would make
their lives easier.

My $0.02. Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



