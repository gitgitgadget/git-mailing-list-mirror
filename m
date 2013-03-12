From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Tue, 12 Mar 2013 07:00:03 -0400
Message-ID: <20130312110003.GD11340@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165857.GC1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 12:00:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFMwf-000547-54
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 12:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616Ab3CLLAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 07:00:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49551 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab3CLLAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 07:00:07 -0400
Received: (qmail 25930 invoked by uid 107); 12 Mar 2013 11:01:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 07:01:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 07:00:03 -0400
Content-Disposition: inline
In-Reply-To: <20130310165857.GC1136@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217945>

On Sun, Mar 10, 2013 at 05:58:57PM +0100, Heiko Voigt wrote:

> The only location where cf is set in this file is in do_config_from().
> This function has only one callsite which is config_from_file(). In
> config_from_file() its ensured that the f member is set to non-zero.
> [...]
> -	if (cf && ((f = cf->f) != NULL)) {
> +	if (cf) {

I still think we can drop this conditional entirely. The complete call
graph looks like:

  git_config_from_file
    -> git_parse_file
      -> get_next_char
      -> get_value
          -> get_next_char
          -> parse_value
              -> get_next_char
      -> get_base_var
          -> get_next_char
          -> get_extended_base_var
              -> get_next_char

That is, every path to get_next_char happens while we are in
git_config_from_file, and that function guarantees that cf = &top, and
that top.f != NULL.  We do not have to even do any analysis of the
conditions for each call, because we never change "cf" nor "top.f"
except when we set them in git_config_from_file.

-Peff
