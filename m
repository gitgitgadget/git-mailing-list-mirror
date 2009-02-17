From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3] git-archive: Add new option "--output" to write  
 archive to a file instead of stdout.
Date: Tue, 17 Feb 2009 23:59:50 +0100
Message-ID: <499B4166.90609@lsrfire.ath.cx>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D6@NOK-EUMSG-02.mgdnok.nokia.com> <7v7i3o6h8x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: carlos.duclos@nokia.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYwW-0004HM-9t
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbZBQXAC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 18:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZBQXAB
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:00:01 -0500
Received: from india601.server4you.de ([85.25.151.105]:34736 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbZBQXAB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:00:01 -0500
Received: from [10.0.1.101] (p57B7D224.dip.t-dialin.net [87.183.210.36])
	by india601.server4you.de (Postfix) with ESMTPSA id 927082F8057;
	Tue, 17 Feb 2009 23:59:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7v7i3o6h8x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110468>

Junio C Hamano schrieb:
> <carlos.duclos@nokia.com> writes:
>> +static void create_output_file(const char *output_file)
>> +{
>> +	int output_fd =3D open(output_file, O_CREAT | O_WRONLY | O_TRUNC, =
0666);
>> +	if (output_fd < 0)
>> +		die("could not create archive file: %s ", output_file);
>> +	if (output_fd !=3D 1)
>> +		if (dup2(output_fd, 1) < 0) {
>> +			/*
>> +			 * dup2 closes output_fd on success, if something=20
>> +			 * goes wrong we close output_fd here to avoid
>> +			 * problems.
>> +			 */
>> +			close(output_fd);
>> +			die("could not redirect output");
>=20
> The comment and close() are probably unnecessary, as you will die()
> immediately.

dup2() closes the second file, not the first one (but not if it's the
same as the first one), so the comment is incorrect.  And I agree it's
OK to just die() without cleaning up, as this is a fatal error anyway
and an unlikely one on top of that.  How about something like this?

	if (dup2(output_fd, 1) < 0)
		die("could not redirect output");
	close(output_fd);

Ren=C3=A9
