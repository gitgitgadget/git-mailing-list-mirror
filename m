From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 08 Feb 2008 21:27:12 -0800
Message-ID: <7vk5leg0nj.fsf@gitster.siamese.dyndns.org>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
	<alpine.LNX.1.00.0802081526350.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:28:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiG0-0002vD-5R
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbYBIF1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 00:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbYBIF1e
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:27:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYBIF1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 00:27:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F57813CA;
	Sat,  9 Feb 2008 00:27:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CDF713C8;
	Sat,  9 Feb 2008 00:27:24 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802081526350.13593@iabervon.org> (Daniel
	Barkalow's message of "Fri, 8 Feb 2008 15:36:05 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73191>

Daniel Barkalow <barkalow@iabervon.org> writes:

> diff --git a/remote.c b/remote.c
> index 0e00680..83a3d9d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -348,7 +348,7 @@ struct remote *remote_get(const char *name)
>         if (!name)
>                 name = default_remote_name;
>         ret = make_remote(name, 0);
> -       if (name[0] != '/') {
> +       if (name[0] != '/' && strcmp(name, "..")) {
>                 if (!ret->url)
>                         read_remotes_file(ret);
>                 if (!ret->url)

Perhaps "static int valid_remote_nick(const char*)" is needed?
I'd say we can limit it to something like:

static int valid_remote_nick(const char *name)
{
	if (!name[0] || /* not empty */
            (name[0] == '.' && /* not "." */
             (!name[1] || /* not ".." */
              (name[1] == '.' && !name[2]))))
		return 0;
	return !!strchr(name, '/'); /* no slash */
}
