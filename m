From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 12:51:44 -0700
Message-ID: <7vhcak5o6n.fsf@gitster.siamese.dyndns.org>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
 <1216490252.10694.58.camel@koto.keithp.com>
 <1216491512.3911.9.camel@pc7.dolda2000.com>
 <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness>
 <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807202035090.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 21:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKexj-0006qc-LB
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 21:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbYGTTv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 15:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbYGTTv4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 15:51:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYGTTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 15:51:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 329E92FC71;
	Sun, 20 Jul 2008 15:51:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7B7DB2FC6E; Sun, 20 Jul 2008 15:51:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807202035090.3305@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 20 Jul 2008 20:57:48 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4CF0CD0C-5695-11DD-BABC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89220>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about this instead?
>
> -- snipsnap --
> diff --git a/connect.c b/connect.c
> index 574f42f..7e7f4d3 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -603,7 +603,8 @@ struct child_process *git_connect(int fd[2], const char *url
>  
>  		*arg++ = ssh;
>  		if (port) {
> -			*arg++ = "-p";
> +			const char *opt = getenv("GIT_SSH_PORT_OPTION");
> +			*arg++ = opt ? opt : "-p";
>  			*arg++ = port;
>  		}
>  		*arg++ = host;

If you only care only about the ones we currently want to support, I do
not htink it makes any difference either way, but if we are shooting for
having a minimum-but-reasonable framework to make it easy to support other
ones that we haven't seen, it feels very much like an inadequate hack to
waste an envirnoment variable for such a narrow special case.  With this,
what you really mean is "Plink uses -P instead of -p", right?

I do not know if "plink" is used widely enough to be special cased, but if
so, I think we would better have an explicit support for it.  Will we add
GIT_SSH_FORBID_X11_FORWARDING_OPTION environment variable and friends,
too?

The extra environment would not help dealing with an implementation that
wants --port=90222 (i.e. not as two separate arguments but a single one),
for example.  You would need the extra wrapper support for that kind of
thing anyway.  That extra environment _solution_ will need to make an
assuption that any reasonable implementation would have an option string
to specify port which may not be "-p" and that is to be followed by a
separate argument that is a decimal port number, which probably is
reasonable for this particular "port" thing, but as a general design
principle I do not think it is a good direction to go.
