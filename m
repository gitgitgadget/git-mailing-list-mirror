From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Teach git-bundle to read revision arguments from stdin like
 git-rev-list
Date: Sat, 05 Jul 2008 17:57:40 -0700
Message-ID: <7v63rjrfqz.fsf@gitster.siamese.dyndns.org>
References: <20080705204849.GJ4729@genesis.frugalware.org>
 <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
 <1215293200-28199-2-git-send-email-adambrewster@gmail.com>
 <1215293200-28199-3-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, mdl123@verizon.net,
	Johannes.Schindelin@gmx.de, jnareb@gmail.com,
	vmiklos@frugalware.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 02:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFIag-0005YD-5u
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 02:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbYGFA57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 20:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbYGFA57
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 20:57:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbYGFA56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 20:57:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C98318172;
	Sat,  5 Jul 2008 20:57:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B380E18170; Sat,  5 Jul 2008 20:57:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93475F64-4AF6-11DD-A29D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87479>

Adam Brewster <adambrewster@gmail.com> writes:

> @@ -227,8 +228,16 @@ int create_bundle(struct bundle_header *header, const char *path,
>  
>  	/* write references */
>  	argc = setup_revisions(argc, argv, &revs, NULL);
> -	if (argc > 1)
> -		return error("unrecognized argument: %s'", argv[1]);
> +
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--stdin")) {
> +			if (read_from_stdin++)
> +				die("--stdin given twice?");

Hmm, do we deeply care about this case?  What bad things coulc happen if
you call read_revisions_from_stdin() twice?

> +			read_revisions_from_stdin(&revs);
> +			continue;
> +		}
> +		return error("unrecognized argument: %s'", argv[i]);
> +	}
>  
>  	for (i = 0; i < revs.pending.nr; i++) {
>  		struct object_array_entry *e = revs.pending.objects + i;
