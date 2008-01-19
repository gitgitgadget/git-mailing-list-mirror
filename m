From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: fix webdav lock leak.
Date: Sat, 19 Jan 2008 23:08:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192302340.5731@racer.site>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1897453856-1200784124=:5731"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 00:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMoX-0004Na-Ei
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 00:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbYASXI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 18:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbYASXIz
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 18:08:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:34377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753409AbYASXIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 18:08:55 -0500
Received: (qmail invoked by alias); 19 Jan 2008 23:08:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp020) with SMTP; 20 Jan 2008 00:08:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Du7MCaHZDUyMDkZ+uLniX5V+0nJMuNUfuiSMM7m
	Th0pD0S95aVjB+
X-X-Sender: gene099@racer.site
In-Reply-To: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71139>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1897453856-1200784124=:5731
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 19 Jan 2008, Grégoire Barbier wrote:

> diff --git a/http-push.c b/http-push.c
> index eef7674..2c4e91d 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2264,11 +2264,14 @@ int main(int argc, char **argv)
>  	if (!remote_tail)
>  		remote_tail = &remote_refs;
>  	if (match_refs(local_refs, remote_refs, &remote_tail,
> -		       nr_refspec, (const char **) refspec, push_all))
> -		return -1;
> +		       nr_refspec, (const char **) refspec, push_all)) {
> +		rc = -1;
> +		goto cleanup;
> +	}
>  	if (!remote_refs) {
>  		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
> -		return 0;
> +		rc = 0;
> +		goto cleanup;
>  	}
>  
>  	new_refs = 0;
> @@ -2399,10 +2402,10 @@ int main(int argc, char **argv)
>  			fprintf(stderr, "Unable to update server info\n");
>  		}
>  	}
> -	if (info_ref_lock)
> -		unlock_remote(info_ref_lock);
>  
>   cleanup:
> +	if (info_ref_lock)
> +		unlock_remote(info_ref_lock);
>  	free(remote);

This late in the rc cycle, together with my unfamiliarity of the code and 
the code paths in http.c and http-push.c would make me feel _much_ better 
if you could insert the "if (info_ref_lock)" before the returns, instead 
of replacing the returns with "goto cleanup"s...

Thanks,
Dscho

---1463811741-1897453856-1200784124=:5731--
