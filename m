From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 08 Feb 2008 12:33:15 -0800
Message-ID: <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: "Morten Welinder" <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZvH-0002yY-7b
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761820AbYBHUdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbYBHUdh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:33:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043AbYBHUdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:33:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A7B8A558F;
	Fri,  8 Feb 2008 15:33:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D6F7558E;
	Fri,  8 Feb 2008 15:33:28 -0500 (EST)
In-Reply-To: <118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com>
	(Morten Welinder's message of "Fri, 8 Feb 2008 15:15:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73136>

"Morten Welinder" <mwelinder@gmail.com> writes:

>> +/* Helper function to ensure that we are opening a file and not a directory */
>> +static FILE *open_file(char *full_path)
>> +{
>> +       struct stat st_buf;
>> +       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
>> +               return NULL;
>> +       return (fopen(full_path, "r"));
>> +}
>
> That looks wrong.  stat+fopen has a pointless race condition that
> open+fstat+fdopen would not have.

That's true.  How about doing something like this?

 (1) in a new file "compat/gitfopen.c" have this:

	#include "../git-compat-util.h"
	#undef fopen
	FILE *gitfopen(const char *path, const char *mode)
        {
		int fd, flags;
                struct stat st;
        	if (mode[0] == 'w')
                	return fopen(path, mode);
		switch (mode[0]) {
                case 'r': flags = O_RDONLY; break;
                case 'a': flags = O_APPEND; break;
		default:
			errno = EINVAL;
                	return NULL;
		}
		fd = open(path, flags);
		if (fd < 0 || fstat(fd, &st))
                	return NULL;
		if (S_ISDIR(st_buf.st_mode)) {
                	errno = EISDIR;
                        return NULL;
		}
		return fdopen(fd, mode);
	}

  (2) in "git-compat-util.h" have this:

	#ifdef FOPEN_OPENS_DIRECTORIES
        #define fopen(a,b) gitfopen(a,b)
	extern FILE *gitfopen(const char *, const char *);
        #endif

And have Makefile set FOPEN_OPENS_DIRECTORIES on appropriate
platforms.
