From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] vcs-svn: Refactor dump_export code into dispatch
 table
Date: Tue, 1 Feb 2011 11:42:41 -0600
Message-ID: <20110201174241.GB3771@burratino>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKFm-0007j5-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab1BARmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 12:42:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51617 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1BARmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 12:42:49 -0500
Received: by fxm20 with SMTP id 20so7059551fxm.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 09:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LB8ic2twC/CF742reafOXC6K16dnNKFxHPkSKaOR89U=;
        b=Oxmwk/SYBi07PM9zXprehTV0wSxj6+9uH6WDhKGmjLc0oVUt2UEguxEMlq1EJHOqUh
         ffUOcE1XAW8xjX6B3h/NIMbOafnIribsXioMoI5v0MYdcbQT+Av8pM4mwIgOsMt2QIbP
         2hybCYH5ntubjRsUwwJxreFr0QedaIuKz2+6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hiytI5d/nPvGn9PxK8IWn5VRQ894soVLj1eAic+CY1dvu1rX5aov5V6WJKma28ZEad
         tzY7EutTCrMoKQEU37hwg8FwBNjqPkXMj3FXXHO1fYPBBdOwzZYzzVLdKs99t1khGuh6
         iq3j5TGYk4Ms3qD5SoJFNtc5mPurIPGqK8mbk=
Received: by 10.223.70.136 with SMTP id d8mr1889636faj.3.1296582168559;
        Tue, 01 Feb 2011 09:42:48 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.sbcglobal.net [69.209.75.28])
        by mx.google.com with ESMTPS id 11sm3177796faw.20.2011.02.01.09.42.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 09:42:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296570403-9082-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165833>

Ramkumar Ramachandra wrote:

> +++ b/vcs-svn/dump_export.c
> @@ -11,6 +11,48 @@
[...]
> +static state_fn *const dispatch_table[NODE_KIND_COUNT][NODE_ACTION_COUNT] = {
> +	/* NODE_KIND_UNKNOWN */
> +	{abort, abort, abort, Adelete, abort},
> +	/* NODE_KIND_NORMAL */
> +	{abort, Nchange, Nadd, Adelete, Nreplace},
> +	/* NODE_KIND_EXECUTABLE */
> +	{abort, Echange, Eadd, Adelete, Ereplace},
> +	/* NODE_KIND_SYMLINK */
> +	{abort, Schange, Sadd, Adelete, Sreplace},
> +	/* NODE_KIND_GITLINK */
> +	{abort, abort, abort, abort, abort},
> +	/* NODE_KIND_DIR */
> +	{abort, Dchange, Dadd, Adelete, Dreplace},
> +	/* NODE_KIND_SUBDIR */
> +	{abort, abort, abort, abort, abort}
> +};

Heh.  I think that Junio was suggesting making the _parser_
table-driven, meaning something like

	... node_kinds[] = {
		{ "100644", sizeof("100644"), "file" },
		{ "100755", sizeof("100755"), "file", "svn:executable" },
		{ "120000", sizeof("120000"), "file", "svn:special" },
		{ "160000", sizeof("160000"), "file" },	/* NEEDSWORK: seems wrong" */
		{ "040000", sizeof("040000"), "dir" }
	};

(Side note: remember that 644 and 755 are permitted synonyms for
100644 and 100755!)

I personally think that simple state machines tend to be easier to
follow if the current state is represented by the instruction pointer
rather than a variable, as in the current fast-import.c.  But maybe
that's a matter of taste?

Anyway, my other complaints about this dispatch_table are that the
function names leave me rubbing my head and I can't keep the list
of states you're transitioning between straight in my head.  I guess
"Adelete" is an abbreviation for print_delete_node_action?  Is a
callback needed at all (rather than just a string) for such actions?

Hope that helps,
Jonathan
