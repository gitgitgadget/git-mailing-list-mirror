From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Sun, 10 Feb 2013 21:11:59 +0530
Message-ID: <CALkWK0mjEmErd2A5qb8qdfNMSXG1L0dt8A=ecbSVFGPEg5MxkA@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
 <7v8v6y1sih.fsf@alter.siamese.dyndns.org> <CALkWK0kp5SvbeTQgLRKWUAT_koSi0wyp6iPTC324iH8+D8oeJg@mail.gmail.com>
 <7vhallw946.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:42:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Z3G-0002sB-LB
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab3BJPmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:42:20 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:57662 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3BJPmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:42:19 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so6673617iea.7
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 07:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vD75nrbLnE6KIrp0kNGbsSRzoStEsaf/0/TA8BxkLyQ=;
        b=Hw9UlPukdpQ3q7R4MscRudJcvHtH0HxAt870ViF7jPgGX2O45Fac+7Vy1wfZ6A+Oxv
         Ii6XRGGFzLV/qxr/CLStdmU+JxArLJya7GLoBRnmAAn4G8uxebhsmlVh/7VXQosdAUSQ
         N+CxTNEAmVio6le79piWyrDSsB7zGNcmOEcS9r8BJb4jFNZ8UyMSg5VFJath6T164Sor
         ybz3J+/sj2paJi8ijjeN08Jo/H86NR1dgo23UzPsbYClOBGkFi1DQg3luyydGTgrru/9
         rrkC095JVmvEEsBlxRO+BJXGu/1BtoXeYD5K0qCJOmiRGfr9B2qni1QzzB7VcH0Nn2WV
         P5IA==
X-Received: by 10.50.237.5 with SMTP id uy5mr9944948igc.12.1360510939239; Sun,
 10 Feb 2013 07:42:19 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Sun, 10 Feb 2013 07:41:59 -0800 (PST)
In-Reply-To: <7vhallw946.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215923>

Junio C Hamano wrote:
>         struct bp { const char *branch; const char *remotename; };
>
>         static int pushremote(const char *var, const char *val, void *cb)
>         {
>                 struct bp *bp = cb;
>                 const char *name, *key;
>                 int namelen;
>
>                 if (!parse_config_key(var, "branch", &name, &namelen, &key) &&
>                     namelen == strlen(bp->branch) &&
>                     !memcmp(name, bp->branch, name, namelen) &&
>                     !strcmp(key, "remotepush")) {
>                         git_config_string(&bp->remotename, var, val);
>                 }
>                 return 0;
>         }
>
>         char *find_pushremote(void) {
>                 struct bp bp;
>
>                 bp.branch = get_current_branch();
>                 bp.remotename = NULL;
>                 git_config(pushremote, &bp);
>                 return bp.remotename;
>         }

I don't get the point of your illustration.  First, we never deal with
a char * branch anywhere: handle_config() immediately calls
make_branch() as soon as it parses the name from the config.  Second,
remote_name is already bundled with the branch struct: why do you need
a new bp struct?  This is how I would do it without relying on a
global:

	static int handle_config(const char *key, const char *value, void *cb) {
		/* parse branch name here */
		/* ... */
		branch = make_branch(name);
		if (!strcmp(subkey, ".pushremote"))
			branch->pushremote_name = xstrdup(value);
	}

	struct remote *pushremote_get(struct branch *this_branch)
	{
		if (this_branch == get_current_branch())
			name = this_branch->pushremote_name;
		/* ... */
		return make_remote(name);
	}

Essentially, I need to know for which branch we're trying to get the
pushremote: hence the parameter this_branch to pushremote_get().

> But there is no reason for anybody to want to know the value for the
> variables branch.$name.pushremote for all defined $name's at the
> same time, exactly because this matters only for the current branch,
> no?

Ah, yes.  You are right.  There's no harm in having globals because
there can really be only one current branch, and only one pushremote
corresponding to that.  It's just that globals tend to confuse me in
general, because I have to keep track of a maze of functions that are
getting/ setting them.
