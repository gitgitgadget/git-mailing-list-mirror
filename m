From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: importing mercurial patch
Date: Tue, 11 Nov 2008 15:41:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811111454330.30769@pacific.mpi-cbg.de>
References: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>  <alpine.DEB.1.00.0811111258260.30769@pacific.mpi-cbg.de> <85b5c3130811110418l11be8084sf0f47a1095755747@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Tue Nov 11 15:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzuKh-0000PG-5R
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 15:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbYKKOdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 09:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbYKKOdw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 09:33:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:42616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753612AbYKKOdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 09:33:51 -0500
Received: (qmail invoked by alias); 11 Nov 2008 14:33:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 11 Nov 2008 15:33:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wmEkb0AewwKzMmTypeYF6C1RbJE7bkUL33J3Ibj
	3hJDIKJCws/WL3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85b5c3130811110418l11be8084sf0f47a1095755747@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100646>

Hi,

On Tue, 11 Nov 2008, Ondrej Certik wrote:

> But imho if git supported mercurial patches, life would be a lot easier.

Mine would not be.

BTW I had to be online (which is not always the case when I read email) to 
access the pastebin, which made it more of a hassle to look at it than I 
deem necessary.  Besides, it is bad because in 3 days, that pastie will be 
gone.  Not nice.

So here is it, for the pleasure of others:

	# HG changeset patch
	# User Vinzent Steinberg <vinzent.steinberg@gmail.com>
	# Date 1226338168 -3600
	# Node ID 23efeaf89f7089d94307526ec0536eb6f4382213
	# Parent  dab6435e04fd083d66bbfa897cbe15ab9660b9e6
	<commit subject>

	<commit body>

	diff -r <commit name> -r <commit name> <filename>
	--- a/<filename> <date>
	--- b/<filename> <date>
	@@ <line range pair> @@
	...

So what I suggest is that you familiarize yourself with 
builtin-mailsplit.c.  Basically you'd need to enhance the is_from_line() 
function to check this:

	const char *hg_patch_preamble = "# HG changeset patch\n";

	if (len >= strlen(hg_patch_preamble) && !memcmp(line, 
			hg_patch_preamble, strlen(hg_patch_preamble))
		return 1;

Then you need to familiarize yourself with builtin-mailinfo.c.  In 
function mailinfo(), you'd need to work on this:

        /* process the email header */
        while (read_one_header_line(&line, fin))
                check_header(&line, p_hdr_data, 1);

I'd suggest to make the function read_one_header_line() into a 
handle_one_header_line(), and replace the while loop with this:

	if (!strbuf_getline(&line, fin)) {
		if (!strcmp(line.buf, "# HG changeset patch\n"))
			while (handle_one_hg_header_line(&line, 
					p_hdr_data, fin))
				strbuf_getline(&line, fin);
		else
			while (handle_one_header_line(&line, fin)) {
				check_header(&line, p_hdr_data, 1);
				strbuf_getline(&line, fin);
			}
	}

Implementing handle_one_hg_header_line() should be a breeze:

	static int handle_one_hg_header_line(struct strbuf *line,
			struct strbuf *hdr_data[], FILE *in)
	{
		if (line.buf[0] != '#') {
			strbuf_addbuf(hdr_data[1], line);
			return 0; /* no more headers */
		}

		if (!prefixcmp(line.buf, "# User "))
			strbuf_addstr(hdr_data[0], line.buf + 7);
		else if (!prefixcmp(line.buf, "# Date "))
			strbuf_addstr(hdr_data[2], line.buf + 7);
		return 1;
	}

Okay, this is all utterly untested, and you probably need to trim the 
newlines from the lines first, and maybe you need to replace the 
hdr_data[] entries instead of adding to them, but now you have a starting 
point.

Hth,
Dscho
