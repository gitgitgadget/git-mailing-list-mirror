From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-daemon: single-line logs
Date: Wed, 14 Jan 2009 03:33:38 -0800
Message-ID: <7vy6xe2kbx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 12:35:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN41b-0008Ke-UB
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 12:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbZANLdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 06:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbZANLdo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 06:33:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbZANLdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 06:33:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 90ACD90484;
	Wed, 14 Jan 2009 06:33:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7A7E490480; Wed,
 14 Jan 2009 06:33:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 32DEFB84-E22F-11DD-865F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105619>

Jan Engelhardt <jengelh@medozas.de> writes:

> parent v1.6.1
>
> git-daemon: single-line logs

Please drop these two needless lines when/if you are submitting patches
for inclusion..

> Having just a single line per connection attempt, much like Apache
> httpd2 access logs, makes log parsing much easier, especially when
> just glancing over it non-automated.

While I like the motivation, and I wish the log were as terse as possible
from the day one, I think changing the output format unconditionally like
this patch does is a horrible idea.  I'd expect there are many people who
already have their infrastructure set up to parse the current output; this
patch actively breaks things for them, doesn't it?

> @@ -295,12 +295,13 @@ static int git_daemon_config(const char
>  	return 0;
>  }
>  
> -static int run_service(char *dir, struct daemon_service *service)
> +static int run_service(char *dir, struct daemon_service *service,
> +    const char *origin, const char *vhost)
>  {
>  	const char *path;
>  	int enabled = service->enabled;
>  
> -	loginfo("Request %s for '%s'", service->name, dir);
> +	loginfo("%s->%s %s \"%s\"\n", origin, vhost, service->name, dir);

Mental note.  You are adding origin and vhost probably because you are
losing them from elsewhere..

> @@ -507,10 +508,10 @@ static void parse_extra_args(char *extra
>  static int execute(struct sockaddr *addr)
>  {
>  	static char line[1000];
> +	char addrbuf[256] = "";
>  	int pktlen, len, i;
>  
>  	if (addr) {
> -		char addrbuf[256] = "";
>  		int port = -1;
>  
>  		if (addr->sa_family == AF_INET) {
> @@ -529,7 +530,6 @@ static int execute(struct sockaddr *addr
>  			port = ntohs(sin6_addr->sin6_port);
>  #endif
>  		}
> -		loginfo("Connection from %s:%d", addrbuf, port);

Mental note.  Port is not logged anymore here.

> @@ -541,10 +541,6 @@ static int execute(struct sockaddr *addr
>  	alarm(0);
>  
>  	len = strlen(line);
> -	if (pktlen != len)
> -		loginfo("Extended attributes (%d bytes) exist <%.*s>",
> -			(int) pktlen - len,
> -			(int) pktlen - len, line + len + 1);

Mental note.  XA are not logged here anymore.

> @@ -569,7 +565,8 @@ static int execute(struct sockaddr *addr
>  			 * Note: The directory here is probably context sensitive,
>  			 * and might depend on the actual service being performed.
>  			 */
> -			return run_service(line + namelen + 5, s);
> +			return run_service(line + namelen + 5, s,
> +			       addrbuf, hostname);
>  		}
>  	}

So not just you are changing the format, but you are losing information as
well.

By the way, I think hostname has already been freed and NULLed at this
call site.  Aren't you getting entries like:

	192.168.0.1->(null) upload-pack "/pub/git.git"

in your log?
