From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3 2/3] fast-import: add option command
Date: Fri, 14 Aug 2009 08:37:07 -0700
Message-ID: <20090814153707.GT1033@spearce.org>
References: <1250190156-4752-1-git-send-email-srabbelier@gmail.com> <1250190156-4752-2-git-send-email-srabbelier@gmail.com> <1250190156-4752-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 17:37:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbyqE-0003L0-RM
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 17:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbZHNPhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 11:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbZHNPhI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 11:37:08 -0400
Received: from george.spearce.org ([209.20.77.23]:51243 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbZHNPhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 11:37:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E26D2381FD; Fri, 14 Aug 2009 15:37:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250190156-4752-3-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125932>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> +`option`
> +~~~~~~~~
> +Processes the specified option so that git fast-import behaves in a
> +way that suits the frontend's needs.
> +Note that options specified by the frontend are overridden by any
> +options the user may specify to git fast-import itself.

Wha?  This disagrees with the code.

> +static void read_marks(void)
> +{
> +	char line[512];
> +	FILE *f = fopen(input_file, "r");
...
> +static void option_import_marks(const char *marks)
>  {
> -	char line[512];
> -	FILE *f = fopen(input_file, "r");

This is a nasty refactoring, I would prefer to see it done in its
own commit, "move option_import_marks so it can be called during
command processing".

> @@ -2517,9 +2556,16 @@ int main(int argc, const char **argv)
>  			parse_checkpoint();
>  		else if (!prefixcmp(command_buf.buf, "progress "))
>  			parse_progress();
> +		else if (!prefixcmp(command_buf.buf, "option "))
> +			parse_option();
>  		else
>  			die("Unsupported command: %s", command_buf.buf);
>  	}
> +
> +	// argv hasn't been parsed yet, do so
> +	if (!seen_non_option_command)
> +		parse_argv();

This is too late.  Options like --date-format or --max-pack-size or
--depth or --active-branches all influence the command processing
above.  Parsing these at the end means they have no affect on the
import, which is wrong.

Oh, and --active-branches or --max-pack-size or --depth are really
good examples of things that maybe you do want to override on the
command line.  They have impact only on memory usage of the running
import process, and the local disk usage.  Maybe the frontend has
given too many active branches for your physical memory, and you
want a lower threshold.

So yea, I really do think its a good idea for command line options
to override stream options, despite what Dscho may think.  :-)

-- 
Shawn.
