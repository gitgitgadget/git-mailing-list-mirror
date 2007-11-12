From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Mon, 12 Nov 2007 14:48:46 -0500
Message-ID: <1194896926.2869.15.camel@hinata.boston.redhat.com>
References: <473463E0.7000406@gmail.com>
	 <7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
	 <1b46aba20711120509l104792ebo4ea9a51c710510f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfI8-0001Gp-Dg
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbXKLTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758523AbXKLTtO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:49:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758428AbXKLTtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:49:12 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lACJmqiw020085;
	Mon, 12 Nov 2007 14:48:52 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lACJmp0S022523;
	Mon, 12 Nov 2007 14:48:51 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lACJmpkS015948;
	Mon, 12 Nov 2007 14:48:51 -0500
In-Reply-To: <1b46aba20711120509l104792ebo4ea9a51c710510f3@mail.gmail.com>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64691>

On Mon, 2007-11-12 at 14:09 +0100, Carlos Rica wrote:
> 2007/11/10, Junio C Hamano <gitster@pobox.com>:
> > Carlos Rica <jasampler@gmail.com> writes:
...
> Then, Kristian, what are you willing to do in such case?
> It seems easier for me to concatenate of -m and -F options, even when
> both types are given. I don't know why "people" want multiple -m options,
> but I think that mixing -m and -F options could be interesting for them too.
> If someone know if this have been discussed and decided already,
> please give me the link.

I should be pretty easy to just append the contents of multiple fies,
even inter-mingled with -m options.  We just do a callback like Johannes
just did for -m in builtin-commit.c for -F and append to the same
strbuf.  strbuf_read() already appends, so the callback could look
something like:

static int opt_parse_F(const struct option *opt, const char *arg, int
unset)
{
        struct strbuf *buf = opt->value;

	if (!strcmp(arg, "-")) {
                if (isatty(0))
                        fprintf(stderr, "(reading log message from
standard input)\n");
                if (strbuf_read(&sb, 0, 0) < 0)
                        die("could not read log from standard input");
	} else {
                if (strbuf_read_file(&sb, logfile, 0) < 0)
                        die("could not read log file '%s': %s",
                            logfile, strerror(errno));
	}
}

Shouldn't be too hard :)
Kristian
