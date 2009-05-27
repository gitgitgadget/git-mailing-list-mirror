From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: add support for IPv6
Date: Tue, 26 May 2009 23:28:41 -0700
Message-ID: <7v7i03kqjq.fsf@alter.siamese.dyndns.org>
References: <4A1AEDF2.7060307@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mike@codeweavers.com
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Cd9-0005mX-J0
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 08:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759359AbZE0G2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 02:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759028AbZE0G2l
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 02:28:41 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64549 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659AbZE0G2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 02:28:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090527062842.MWJQ25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 May 2009 02:28:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id wWUi1b0024aMwMQ04WUinM; Wed, 27 May 2009 02:28:42 -0400
X-Authority-Analysis: v=1.0 c=1 a=KXBDSr8jsPIA:10 a=qCZrQ46jRoIA:10
 a=mK_AVkanAAAA:8 a=cO6QobQ9GtJL3ZHPM8oA:9 a=lYaqV7U91jVXpyY6rDcA:7
 a=q_KGFVu7zGlDsftMqiQKU1dLcK0A:4 a=9xyTavCNlvEA:10 a=SodS6OqPmmEl0FGG:21
 a=t7MNVfoJ1ZocmLxU:21
X-CM-Score: 0.00
In-Reply-To: <4A1AEDF2.7060307@googlemail.com> (Benjamin Kramer's message of "Mon\, 25 May 2009 21\:13\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120035>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> Add IPv6 support by implementing name resolution with the
> protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
> code is still available when git is compiled with NO_IPV6.

> diff --git a/imap-send.c b/imap-send.c
> index 8154cb2..861268a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1021,6 +1019,51 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
>  
>  		imap_info("ok\n");
>  	} else {
> +#ifndef NO_IPV6
> +		struct addrinfo hints, *ai0, *ai;
> +		int gai;
> +		char portstr[6];
> +
> +		snprintf(portstr, sizeof(portstr), "%hu", srvc->port);

We already use %h length specifier to explicitly say the parameter is
a short in the IPV4 part of this program, so I am sure this won't regress
anything for people, but I wonder what the point of it is...  (I am not
asking nor even suggesting to change this, by the way).

> +		memset(&hints, 0, sizeof(hints));
> +		hints.ai_socktype = SOCK_STREAM;
> +		hints.ai_protocol = IPPROTO_TCP;
> +
> +		imap_info("Resolving %s... ", srvc->host);
> +		gai = getaddrinfo(srvc->host, portstr, &hints, &ai);
> +		if (gai) {
> +			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
> +			goto bail;

It is Ok for now (as existing codepath liberally uses fprintf() and
fputs() to report errors), but ideally we should start converting these to
error() calls, I think, in a follow-up patch.

> +		}
> +		imap_info("ok\n");
> +
> +		for (ai0 = ai; ai; ai = ai->ai_next) {
> +			char addr[NI_MAXHOST];
> +
> +			s = socket(ai->ai_family, ai->ai_socktype,
> +				   ai->ai_protocol);
> +			if (s < 0)
> +				continue;
> +
> +			getnameinfo(ai->ai_addr, ai->ai_addrlen, addr,
> +				    sizeof(addr), NULL, 0, NI_NUMERICHOST);
> +			imap_info("Connecting to [%s]:%s... ", addr, portstr);

Is forcing to NUMERICHOST done to match IPV4 codepath that does
inet_ntoa()?  I guess that makes sense.

> +			if (connect(s, ai->ai_addr, ai->ai_addrlen) < 0) {
> +				close(s);
> +				s = -1;
> +				perror("connect");
> +				continue;
> +			}
> +
> +			break;
> +		}
> +		freeaddrinfo(ai0);
> +#else /* NO_IPV6 */
> +		struct hostent *he;
> +		struct sockaddr_in addr;
> +
>  		memset(&addr, 0, sizeof(addr));
>  		addr.sin_port = htons(srvc->port);
>  		addr.sin_family = AF_INET;
> @@ -1040,7 +1083,12 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
>  		imap_info("Connecting to %s:%hu... ", inet_ntoa(addr.sin_addr), ntohs(addr.sin_port));
>  		if (connect(s, (struct sockaddr *)&addr, sizeof(addr))) {
>  			close(s);
> +			s = -1;
>  			perror("connect");
> +		}
> +#endif
> +		if (s < 0) {
> +			fputs("Error: unable to connect to server.\n", stderr);
>  			goto bail;
>  		}

I do not use imap-send myself, and I suspect not many people do so either,
so I originally guessed the best way to judge if this has any portability
(or other) issues is to directly apply to 'master' and see if anybody
screams.

Thanks.
