Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A789320986
	for <e@80x24.org>; Tue, 27 Sep 2016 21:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbcI0Vvp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 17:51:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38848 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753108AbcI0Vvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 17:51:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 763BA20986;
        Tue, 27 Sep 2016 21:51:43 +0000 (UTC)
Date:   Tue, 27 Sep 2016 21:51:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Resumable clone
Message-ID: <20160927215143.GA32622@starla>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> wrote:
> Hey, all,
> 
> It's been a while (sent a very short patch in May), but I've
> still been working on the resumable clone feature and checking up on
> the mailing list for any updates. After submitting the prime-clone
> service alone, I figured implementing the whole thing would be the best
> way to understand the full scope of the problem (this is my first real
> contribution here, and learning while working on such an involved
> feature has not been easy). 

Thank you for working on this.  I'm hugely interested in this
feature as both a cheapskate sysadmin and as a client with
unreliable connectivity (and I've barely been connected this month).

> This is a functional implementation handling a direct http/ftp URI to a
> single, fully connected packfile (i.e. the link is a direct path to the
> file, not a prefix or guess). My hope is that this acts as a bare
> minimum cross-section spanning the full requirments that can expand in
> width as more cases are added (.info file, split bundle, daemon
> download service). This is certainly not perfect, but I think it at
> least prototypes each component involved in the workflow.
> 
> This patch series is based on jc/bundle, because the logic to find the
> tips of a pack's history already exists there (I call index-pack
> --clone-bundle on the downloaded file, and read the file to write the
> references to a temporary directory). If I need to re-implement this
> logic or base it on another branch, let me know. For ease of pulling
> and testing, I included the branch here:
> 
> https://github.com/kevinwern/git/tree/feature/prime-clone

Am I correct this imposes no additional storage burden for servers?

(unlike the current .bundle dance used by kernel.org:
  https://www.kernel.org/cloning-linux-from-a-bundle.html )

That would be great!

> Although there are a few changes internally from the last patch,
> the "alternate resource" url to download is configured on the
> server side in exactly the same way:
> 
> [primeclone]
> 	url = http://location/pack-$NAME.pack
> 	filetype = pack

If unconfigured, I wonder if a primeclone pack can be inferred by
the existence of a pack bitmap (or merely being the biggest+oldest
pack for dumb HTTP).

> The prime-clone service simply outputs the components as:
> 
> ####url filetype
> 0000
> 
> On the client side, the transport_prime_clone and
> transport_download_primer APIs are built to be more robust (i.e. read
> messages without dying due to protocol errors), so that git clone can
> always try them without being dependent on the capability output of
> git-upload-pack. transport_download_primer is dependent on the success
> of transport_prime_clone, but transport_prime_clone is always run on an
> initial clone. Part of achieving this robustness involves adding
> *_gentle functions to pkt_line, so that prime_clone can fail silently
> without dying.
> 
> The transport_download_primer function uses a resumable download,
> which is applicable to both automatic and manual resuming. Automatic
> is programmatically reconnecting to the resource after being
> interrupted (up to a set number of times). Manual is using a newly
> taught --resume option on the command line:
> 
> git clone --resume <resumable_work_or_git_dir>

I think calling "git fetch" should resume, actually.
It would reduce the learning curve and seems natural to me:
"fetch" is jabout grabbing whatever else appeared since the
last clone/fetch happened.

> Right now, a manually resumable directory is left behind only if the
> *client* is interrupted while a new junk mode, JUNK_LEAVE_RESUMABLE,
> is set (right before the download). For an initial clone, if the
> connection fails after automatic resuming, the client erases the
> partial resources and falls through to a normal clone. However, once a
> resumable directory is left behind by the program, it is NEVER
> deleted/abandoned after it is continued with --resume.

I'm not sure if erasing partial resources should ever be done
automatically.  Perhaps a note to the user explaining the
situation and potential ways to correct/resume it.

> I think determining when a resource is "unsalvageable" should be more
> nuanced. Especially in a case where a connection is perpetually poor
> and the user wishes to resume over a long period of time. The timeout
> logic itself *definitely* needs more nuance than "repeat 5 times", such
> as expanding wait times and using earlier successes when deciding to
> try again. Right now, I think the most important part of this patch is
> that these two paths (falling through after a failed download, exiting
> to be manually resumed later) exist.
> 
> Off the top of my head, outstanding issues/TODOs inlcude:
> 	- The above issue of determining when to fall through, when to
> 	  reattempt, and when to write the resumable info and exit
> 	  in git clone.

My current (initial) reaction is: you're overthinking this.

I think it's less surprising to a user to always write resumable
info and let them know how to resume (or abort); rather than
trying to second-guess their intent.

Going by the zero-one-infinity rule, I'd probably attempt an
auto-retry once on socket errors before saving state and bailing
with instructions on how to resume.

If they hit Ctrl-C manually, then just tell them they can
either resume or "rm -r" the directory.

> 	- Creating git-daemon service to download a resumable resource.
> 	  Pretty straightforward, I think, especially if
> 	  http.getanyfile already exists. This falls more under
> 	  "haven't gotten to yet" than dilemma.

I think this could be handled natively by git-daemon for
trickling data to slow clients in the existing event loop (and
expanded to use epoll/kqueue).  Similar to how X-Sendfile works
with (Apache|lighttpd) or X-Accel in nginx.

This would be cheaper than wasting a process (or thread) to
trickle to low-bandwidth clients.  But this may be an
optimization we defer until we've ironed out other parts.

> 	- Logic for git clone to determine when a full clone would
> 	  be superior, such as when a clone is local or a reference is
> 	  given.
> 	- Configuring prime-clone for multiple resources, in two
> 	  dimensions: (a) resources to choose from (e.g. fall back to
> 	  a second resource if the first one doesn't work) and (b)
> 	  resources to be downloaded together or in sequence (e.g.
> 	  download http://host/this, then http://host/that). Maybe
> 	  prime-clone could also handle client preferences in terms of
> 	  filetype or protocol. For this, I just have to re-read a few
> 	  discussions about the filetypes we use to see if there are
> 	  any outliers that aren't representable in this way. I think
> 	  this is another "haven't gotten to yet".

Perhaps using the existing http-alternates (and automatic
primeclone pack inference I wrote about above) can be done.

<snip>

> 	- Creating the logic to guess a packfile, and append that to a
> 	  prefix specified by the admin. Additionally, allowing the
> 	  admin to use a custom script to use their own logic to
> 	  output the URL.

Yes :) Though I'm not sure if the custom script is necessary.
