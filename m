From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] defaults for where to merge from (take 3, inline)
Date: Fri, 2 Mar 2007 12:19:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021202080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org>
 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
 <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
 <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
 <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
 <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
 <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch>
 <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E7DC04.5010701@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5nW-0005li-FL
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbXCBLTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423030AbXCBLTf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:19:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:39715 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423027AbXCBLTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:19:34 -0500
Received: (qmail invoked by alias); 02 Mar 2007 11:19:33 -0000
X-Provags-ID: V01U2FsdGVkX1/Vq+oKqKzVA/5HB/m7Q8j3OE+5cUm3y2vknKryjm
	1BIh+O/RfTxhXv
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E7DC04.5010701@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41192>

Hi,

On Fri, 2 Mar 2007, Paolo Bonzini wrote:

> >> +	remote_value[slash - remote_name] = 0;
> > 
> > You should check if slash == NULL and error out before using it.
> 
> remote_name is of the form "REMOTE/BRANCH", because it comes from 
> dwim_ref's output after stripping "refs/remotes/" from the beginning.

You can create a new "remote" branch anytime by

	$ git update-ref refs/remotes/lirumlarum HEAD

Your code would realize that it is a remote ref, strip "refs/remotes/", 
and then call strchr("lirumlarum", '/'), which returns NULL.

On a related note, it _might_ make sense to check that the remote 
information is set as expected:

	static const char *remote_name;
	static int found_remote, remote_name_len;

	static int find_remote(const char *key, const char *value) {
		/*
		 * This checks if
		 * remote.<bla>.fetch == refs/heads/*:refs/heads/<bla>/*
		 * where <bla> is the remote_name.
		 */
		if (!prefixcmp(key, "remote.") &&
				!prefixcmp(key + 7, remote_name) && 
				!strcmp(key + 7 + remote_name_len,
					 ".fetch") &&
				value &&
				!prefixcmp(value, 
					"refs/heads/*:refs/remotes/") &&
				!prefixcmp(value + 26, remote_name) &&
				!strcmp(value + 26 + remote_name, "/*")) {
			found_remote = 1;
			return -1; /* stop parsing config */
		}
		return 0;
	}

and then in remote_pull():

	found_remote = 0;
	remote_name = branch_name;
	remote_name_len = slash - branch_name;
	git_config(find_remote);
	if (!found_remote) {
		warn("Remote %s was not created with git-remote; "
			"will not add it as default merge source to %s",
			branch_name, name);
		return;
	}

We could rely on new git users not to fiddle with the remote information 
in the config, and old-timers still using .git/remotes/ or .git/branches 
would be told why the default merge information was not set up.

Ciao,
Dscho
