From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC/WIP PATCH 3/4] teach add -f option for ignored
 submodules
Date: Mon, 9 Dec 2013 22:51:02 +0100
Message-ID: <20131209215102.GE9606@sandbox-ub>
References: <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
 <20131204222156.GD7326@sandbox-ub>
 <xmqqob4t1spk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:51:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8jT-0003WN-IT
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761505Ab3LIVvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:51:12 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:46056 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab3LIVvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:51:09 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vq8jH-0006iC-T8; Mon, 09 Dec 2013 22:51:04 +0100
Content-Disposition: inline
In-Reply-To: <xmqqob4t1spk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239111>

On Fri, Dec 06, 2013 at 03:10:31PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 2d0d2ef..d6cab7f 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -550,6 +569,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  
> >  		for (i = 0; i < pathspec.nr; i++) {
> >  			const char *path = pathspec.items[i].match;
> > +			char path_copy[PATH_MAX];
> >  			if (!seen[i] &&
> >  			    ((pathspec.items[i].magic &
> >  			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
> > @@ -562,6 +582,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  					die(_("pathspec '%s' did not match any files"),
> >  					    pathspec.items[i].original);
> >  			}
> > +			normalize_path_copy(path_copy, path);
> > +			if (is_ignored_submodule(path_copy))
> > +				string_list_insert(&ignored_submodules, path);
> >  		}
> >  		free(seen);
> >  	}
> > @@ -583,6 +606,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >  	update_files_in_cache(prefix, &pathspec, &update_data);
> >  
> >  	exit_status |= !!update_data.add_errors;
> > +	if (!ignored_too && ignored_submodules.nr)
> > +		die_ignored_submodules(&ignored_submodules);
> 
> Why is this done so late in the process?  Shouldn't it be done
> immediately after we have finished iterating over the pathspecs,
> checking with is_ignored_submodule() and stuffing them into
> ignored_submodules string list, not waiting for plugging bulk
> checkin or updating paths already tracked in the index?

There was no specific reason. I just imitated the codepath for new
files (which will die in add_files() if they are ignored). This can be
moved further up. Will do so.

Cheers Heiko
