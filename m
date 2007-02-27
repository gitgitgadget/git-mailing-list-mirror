From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 02:35:29 -0800
Message-ID: <7vejobhor2.fsf@assigned-by-dhcp.cox.net>
References: <11725197603476-git-send-email-nico@cam.org>
	<1172519760216-git-send-email-nico@cam.org>
	<11725197613482-git-send-email-nico@cam.org>
	<11725197622423-git-send-email-nico@cam.org>
	<11725197633144-git-send-email-nico@cam.org>
	<11725197632516-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 11:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLzgE-0007cW-QC
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 11:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXB0Kfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 05:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXB0Kfb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 05:35:31 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45948 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXB0Kfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 05:35:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227103531.FAUC2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 05:35:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UabV1W00S1kojtg0000000; Tue, 27 Feb 2007 05:35:30 -0500
In-Reply-To: <11725197632516-git-send-email-nico@cam.org> (Nicolas Pitre's
	message of "Mon, 26 Feb 2007 14:55:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40706>

Nicolas Pitre <nico@cam.org> writes:

> We currently have two parallel notation for dealing with object types
> in the code: a string and a numerical value.  One of them is obviously
> redundent, and the most used one requires more stack space and a bunch
> of strcmp() all over the place.
>
> This is an initial step for the removal of the version using a char array
> found in object reading code paths.  The patch is unfortunately large but
> there is no sane way to split it in smaller parts without breaking the
> system.
> ...
> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index 6c16bfa..d61d3d5 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -79,7 +79,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
>  int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned char sha1[20];
> -	char type[20];
> +	enum object_type type;
>  	void *buf;
>  	unsigned long size;
>  	int opt;
> ...
>  	case 'p':
> -		if (sha1_object_info(sha1, type, NULL))
> +		type = sha1_object_info(sha1, NULL);
> +		if (type < 0)
>  			die("Not a valid object name %s", argv[2]);

I am wondering if "enum object_type" and signed comparison here
are compatible.  sha1_object_info() is of type "int" so that is
clearly signed, but are we safe assuming this would not result
in "type is unsigned and condition is always false"?
