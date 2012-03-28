From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 16:37:58 -0400
Message-ID: <20120328203758.GA10104@sigill.intra.peff.net>
References: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzd8-0004fp-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab2C1UiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:38:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36349
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757434Ab2C1UiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:38:00 -0400
Received: (qmail 21519 invoked by uid 107); 28 Mar 2012 20:38:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 16:38:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 16:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20120328201851.GA29315@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194189>

On Wed, Mar 28, 2012 at 04:18:51PM -0400, Jeff King wrote:

> +int sane_execvp(const char *file, char * const argv[])
> +{
> +	int ret = execvp(file, argv);
> +	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
> +		errno = ENOENT;
> +	return ret;
> +}

Hmm, this should check for (*file == '/') to handle absolute paths
properly. If you have an absolute path, I would tend to think that we
should never rewrite it into ENOENT (so if you have "/foo/bar", even if
"foo" is inaccessible, ENOENT is still the right response).

-Peff
