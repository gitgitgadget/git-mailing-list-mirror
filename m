From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] svn-fe: Use the cat-blob command to apply deltas
Date: Mon, 18 Oct 2010 04:24:18 -0500
Message-ID: <20101018092418.GB5425@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-6-git-send-email-david.barr@cordelta.com>
 <20101018065657.GE22376@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 11:28:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7m0m-00043H-OT
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 11:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab0JRJ1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 05:27:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65242 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0JRJ1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 05:27:55 -0400
Received: by ywi6 with SMTP id 6so225111ywi.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tjSuZedIVHakm1Cax2zX96kPjLoJ+YN4j4Oo08uKxJ0=;
        b=LgS2xCqmbcdwLns74OAXVF/pkTs/0nGWGzEJvWiPXP2tAuxbsZzaqZ5Aa8wB0sPCFw
         IV1r5lqj2hp6iueijzMfkY3kCjuT+0BrPkno+p8cU7B0kEahIsu/AXrusRIct3N5A45r
         /MZggr2+HB9qnVLy0dJpkd0lNQYyLo9VXGX0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QA93wqHsylI5Rnvo7DViX1MiCXAWTnJ7vFyCkEFuIoOCgxOP1tHK7wYInhVvyP69/6
         Pbiy42p5jagR0LoUR17ULrawRfFdhffu80L/iE1if21skenJqLurmJu2UxgTkXCwHL0a
         ZGOaXepYZL8RzL/FgZbDitWIU4tU7IOr5uTrw=
Received: by 10.90.53.4 with SMTP id b4mr1404379aga.70.1287394074226;
        Mon, 18 Oct 2010 02:27:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t23sm3111009ano.27.2010.10.18.02.27.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 02:27:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018065657.GE22376@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159243>

Hi Ram,

Glad to see you are feeling a little better.

Ramkumar Ramachandra wrote:
> David Barr writes:

>> +	if (!backchannel.infile)
>> +		backchannel.infile = fdopen(REPORT_FILENO, "r");
>> +	if (!backchannel.infile)
>> +		return error("Could not open backchannel fd: %d", REPORT_FILENO);
>
> REPORT_FILENO = 3 is hard-coded. Is this intended? Maybe a
> command-line option to specify the fd?

fast-import gets the --cat-file-fd parameter to choose between stdout,
stdin-as-socket, stderr, or another fd (not necessarily 3 because it
might have to compete with other similar features some day).

For svn-fe, it is just like another stdin.  stdin is always fd 0,
so...

For callers other than svn-fe, it would be especially useful to
make it configurable, yes.

>> +	tail = buffer_read_line(&backchannel);
>> +	if (!tail)
>> +		return 1;
>
> Could you clarify when exactly will this happen?

buffer_read_line() returns NULL on error and when data is exhausted
without the trailing newline appearing.  The input here is supposed to
be just a single newline (trimmed to an empty string).

>> +	long preimage_len = 0;
>> +
>> +	if (delta) {
>> +		if (!preimage.infile)
>> +			preimage.infile = tmpfile();
>
> Didn't you later decide against this and use one tmpfile instead?

This is a single tempfile (because static).  Or am I missing
something?

>> +		if (!preimage.infile)
>> +			die("Unable to open temp file for blob retrieval");
>> +		if (srcMark) {
>> +			printf("cat-blob :%"PRIu32"\n", srcMark);
>> +			fflush(stdout);
>> +			if (srcMode == REPO_MODE_LNK)
>> +				fwrite("link ", 1, 5, preimage.infile);
>
> Special handling for symbolic links. Perhaps you should mention it in
> a comment here?

Or better yet, a comment in the commit message. :)

>> +			if (fast_export_save_blob(preimage.infile))
>> +				die("Failed to retrieve blob for delta application");
>> +		}
>> +		preimage_len = ftell(preimage.infile);
>> +		fseek(preimage.infile, 0, SEEK_SET);
>> +		if (!postimage.infile)
>> +			postimage.infile = tmpfile();
>
> One tmpfile?

Do you mean letting the preimage and postimage share a file?

[...]
>>  	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
>> -	buffer_copy_bytes(input, stdout, len);
>> +	if (!delta)
>> +		buffer_copy_bytes(input, stdout, len);
>> +	else
>> +		buffer_copy_bytes(&postimage, stdout, len);
>>  	fputc('\n', stdout);
>
> I should have asked this a long time ago: why the extra newline?

>From the fast-import manual:

	The LF after <raw> is optional (it used to be required)
	but recommended. Always including it makes debugging a
	fast-import stream easier as the next command always
	starts in column 0 of the next line, even if <raw> did
	not end with an LF.

> Overall, pleasant read. Thanks for taking this forward.

Seconded.  Thanks, both.
