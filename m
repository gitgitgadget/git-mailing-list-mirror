From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: improve performance with large files
Date: Thu, 05 Mar 2009 17:14:40 -0800
Message-ID: <7vzlfzwiyn.fsf@gitster.siamese.dyndns.org>
References: <20090304215438.GA12653@zoy.org>
 <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
 <20090305172332.GF25693@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Hocevar <sam@zoy.org>
To: Simon Hausmann <simon@lst.de>, Han-Wen Nienhuys <hanwen@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 02:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfOfk-0002lj-W8
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 02:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbZCFBOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 20:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbZCFBOw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 20:14:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbZCFBOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 20:14:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7557D9FD7E;
	Thu,  5 Mar 2009 20:14:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C27679FD7C; Thu,
  5 Mar 2009 20:14:42 -0500 (EST)
In-Reply-To: <20090305172332.GF25693@zoy.org> (Sam Hocevar's message of "Thu,
 5 Mar 2009 18:23:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2FAE446C-09EC-11DE-B405-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112364>


Sam Hocevar <sam@zoy.org> writes:

> ... The ideal solution is to use a generator and refactor the commit
> handling as a stream. I am working on that but it involves deeper
> changes, so as I am not sure it will be accepted, I'm providing the
> attached compromise patch first. At least it solves the appaling speed
> issue. I tuned it so that it never uses more than 32 MiB extra memory.
>
> Signed-off-by: Sam Hocevar <sam@zoy.org>
> ---

I do not do p4, but the patch looks obviously correct.  Comments?

>  contrib/fast-import/git-p4 |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 3832f60..151ae1c 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -984,11 +984,19 @@ class P4Sync(Command):
>          while j < len(filedata):
>              stat = filedata[j]
>              j += 1
> +            data = []
>              text = ''
>              while j < len(filedata) and filedata[j]['code'] in ('text', 'unicod
> e', 'binary'):
> -                text += filedata[j]['data']
> +                data.append(filedata[j]['data'])
>                  del filedata[j]['data']
> +                # p4 sends 4k chunks, make sure we don't use more than 32 MiB
> +                # of additional memory while rebuilding the file data.
> +                if len(data) > 8192:
> +                    text += ''.join(data)
> +                    data = []
>                  j += 1
> +            text += ''.join(data)
> +            del data
>
>              if not stat.has_key('depotFile'):
>                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
>
> -- 
> Sam.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
