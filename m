From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 0/4] allow more sources for config values
Date: Tue, 26 Feb 2013 20:30:50 +0100
Message-ID: <20130226193050.GA22756@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQFL-0007Gv-PR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759902Ab3BZTa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:30:59 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:40680 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759779Ab3BZTa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:30:57 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UAQEl-0000PC-4K; Tue, 26 Feb 2013 20:30:51 +0100
Content-Disposition: inline
In-Reply-To: <7v4nh13plo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217163>

Hi,

On Sun, Feb 24, 2013 at 09:54:43PM -0800, Junio C Hamano wrote:
> The idea to allow more kinds of sources specified for "config_file"
> structure is not bad per-se, but whenever you design an enhancement
> to something that currently supports only on thing to allow taking
> another kind, please consider what needs to be done by the next
> person who adds the third kind.  That would help catch design
> mistakes early.  For example, will the "string-list" (I am not
> saying use of string-list makes sense as the third kind; just as an
> example off the top of my head) source patch add
> 
> 	int is_string_list;
>         struct string_list *string_list_contents;
> 
> fields to this structure?  Sounds insane for at least two reasons:
> 
>  * if both is_strbuf and is_string_list are true, what should
>    happen?
> 
>  * is there a good reason to waste storage for the three fields your
>    patch adds when sring_list strage (or FILE * storage for that
>    matter) is used?
> 
> The helper functions like config_fgetc() and config_ftell() sounds
> like you are going in the right direction but may want to do the
> OO-in-C in a similar way transport.c does, keeping a pointer to a
> structure of methods, but I didn't read the remainder of this patch
> very carefully enough to comment further.

I split up my config-from-strings patch from the "fetch moved submodules
on-demand" series[1] for nicer reviewability. Since Peff almost needed it
and the recursive submodule checkout will definitely[2] need it: How
about making it a seperate topic and implement this infrastructure
first?

Junio I incorporated your comments this seems like a result ready for
inclusion.

[1] http://article.gmane.org/gmane.comp.version-control.git/217018
[2] http://article.gmane.org/gmane.comp.version-control.git/217155

Heiko Voigt (4):
  config: factor out config file stack management
  config: drop file pointer validity check in get_next_char()
  config: make parsing stack struct independent from actual data source
  teach config parsing to read from strbuf

 .gitignore             |   1 +
 Makefile               |   1 +
 cache.h                |   1 +
 config.c               | 140 ++++++++++++++++++++++++++++++++++++++-----------
 t/t1300-repo-config.sh |   4 ++
 test-config.c          |  41 +++++++++++++++
 6 files changed, 158 insertions(+), 30 deletions(-)
 create mode 100644 test-config.c

-- 
1.8.2.rc0.26.gf7384c5
