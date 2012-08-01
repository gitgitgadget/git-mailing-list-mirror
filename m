From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Wed, 1 Aug 2012 12:42:48 -0700
Message-ID: <20120801194247.GE24357@copier>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <2351904.F5IazNUWoD@flomedio>
 <CAFzf2XzC4Y1AhBV4BU5zZ411f=oVzoOyNA=e1L2eZd3bjyEgjQ@mail.gmail.com>
 <1447696.eZjtSkvvWp@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:43:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swep4-00017O-B6
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 21:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab2HATnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 15:43:03 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64064 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab2HATnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 15:43:00 -0400
Received: by ggnl2 with SMTP id l2so456321ggn.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+y3d91oz+fyephL+oIvc2ZaWhguMKTNmBWb4IqwFc2c=;
        b=Fu2VUt2Af9WPYcntRSZXVCJMrP+tpi++JdHcAz40aDufxsbp+EZbd3+RubbUue7xrl
         uCuGu2unJEPtnnW7ZHS/QjK+ZuS+OPOY19CuaZGT10KxjZx8go0Lwetuc6gQYG7YQGVq
         p/rW2c2FE+4kvkgtZxVGX71QhoyrOGsMJ8cIL2MqLlh0HbALmxRmKZDt3kXk1Lxlb98k
         Fp09co47jDYFVCCRSsKKZlpeKCNGVsDvJ82FJKKDFLqU6vsC0MpxoUIVCUov5NYhYR3j
         SFXf6YhvH5mmd95nAagwnYbMDzzs07jjPdvQIRq5cpurcPNVkD484baGfoEe0q4tBJEd
         yDAw==
Received: by 10.66.81.202 with SMTP id c10mr42223697pay.20.1343850180163;
        Wed, 01 Aug 2012 12:43:00 -0700 (PDT)
Received: from copier (cl-711.phx-01.us.sixxs.net. [2001:1938:81:2c6::2])
        by mx.google.com with ESMTPS id pt2sm3151084pbb.58.2012.08.01.12.42.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 12:42:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1447696.eZjtSkvvWp@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202721>

Hi again,

Florian Achleitner wrote:

> When the first line arrives at the remote-helper, it starts importing one line 
> at a time, leaving the remaining lines in the pipe.
> For importing it requires the data from fast-import, which would be mixed with 
> import lines or queued at the end of them.

Oh, good catch.

The way it's supposed to work is that in a bidi-import, the remote
helper reads in the entire list of refs to be imported and only once
the newline indicating that that list is over arrives starts writing
its fast-import stream.  We could make this more obvious by not
spawning fast-import until immediately before writing that newline.

This needs to be clearly documented in the git-remote-helpers(1) page
if the bidi-import command is introduced.

If a remote helper writes commands for fast-import before that newline
comes, that is a bug in the remote helper, plain and simple.  It might
be fun to diagnose this problem:

	static void pipe_drained_or_die(int fd, const char *msg)
	{
		char buf[1];
		int flags = fcntl(fd, F_GETFL);
		if (flags < 0)
			die_errno("cannot get pipe flags");
		if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
			die_errno("cannot set up non-blocking pipe read");
		if (read(fd, buf, 1) > 0)
			die("%s", msg);
		if (fcntl(fd, F_SETFL, flags))
			die_errno("cannot restore pipe flags");
	}
	...

	for (i = 0; i < nr_heads; i++) {
		write "import %s\n", to_fetch[i]->name;
	}

	if (getenv("GIT_REMOTE_HELPERS_SLOW_SANITY_CHECK"))
		sleep(1);

	pipe_drained_or_die("unexpected output from remote helper before fast-import launch");

	if (get_importer(transport, &fastimport))
		die("couldn't run fast-import");
	write_constant(data->helper->in, "\n");
