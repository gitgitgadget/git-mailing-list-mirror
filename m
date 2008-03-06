From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-clean: correct printing relative path
Date: Thu, 06 Mar 2008 15:08:47 -0800
Message-ID: <7vr6en8n7k.fsf@gitster.siamese.dyndns.org>
References: <20080306174342.GA32364@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXPDc-000381-54
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 00:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345AbYCFXJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 18:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758271AbYCFXJF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 18:09:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132AbYCFXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 18:09:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4221E2C64;
	Thu,  6 Mar 2008 18:09:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 89D372C62; Thu,  6 Mar 2008 18:08:56 -0500 (EST)
In-Reply-To: <20080306174342.GA32364@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Thu, 6 Mar 2008 20:43:42 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76433>

Dmitry Potapov <dpotapov@gmail.com> writes:

> When the given path contains '..' then git-clean incorrectly printed names
> of files. This patch changes cmd_clean to use quote_path() from wt-status.

I think making quote_path() available from outside is fine, but as a
public function, quote_path() is grossly misnamed.  It was an Ok name in
the context of wt-status, where the sole kind of path quoting necessary
was to show themrelative to the current working directory.  As a general
library, it needs much better name, perhaps quote_path_relative(), and it
should move to quote.c, not staying in wt-status.c.

The implementation of quote_path() also needs to be fixed.  For one thing,
it does not seem to honor core.quotepath configuration, and it also passes
"\t" unquoted.  I think rewriting the handcrafted loop to treat \n and \r
specially should be yanked out and replaced with c_style_quote family of
functions in quote.c
