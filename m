From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for doing
 custom path transformations
Date: Wed, 11 Mar 2009 16:58:25 +0100
Message-ID: <49B7DFA1.4030409@viscovery.net>
References: <1236784647-71388-1-git-send-email-johan@johansorensen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQqj-000355-2j
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbZCKP6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbZCKP6g
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:58:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26379 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZCKP6g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 11:58:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LhQp7-0004Tj-6Q; Wed, 11 Mar 2009 16:58:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4C106D9; Wed, 11 Mar 2009 16:58:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1236784647-71388-1-git-send-email-johan@johansorensen.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112946>

Johan S=F8rensen schrieb:
> The argument is an executable script that will receive the path to th=
e repos
> the client wishes to clone as an argument. It is then the responsibil=
ity of the
> script to return a zero-terminated string on its stdout with the real=
 path of
> the target repository.
>=20
> This buys us a lot of flexibility when it comes to managing different
> repositories, possibly located in many different dirs, but with a uni=
form
> url-structure to the outside world.

It's the first time that I see a deamon with this feature - except perh=
aps
Apache's ModRewrite. Are you sure you are not working around your probl=
em
at the wrong place?

Doesn't --interpolated-path already solve your problem? If not, then yo=
u
at least you must describe in the documentation the use-cases when
--path-filter should be preferred.

Your implementation does not pass the target hostname to the script, bu=
t
it should; otherwise you lose flexibility (for virtual hosting).

> +static char *run_path_filter_script(char *requested_dir) {
> +	pid_t pid;
> +	char result[256]; /* arbitary */
> +	char *real_path;
> +	int pipe_out[2];
> +	int exit_code =3D 1;
> +
> +	pipe(pipe_out);
> +
> +	loginfo("Executing path filter script: '%s %s'", path_filter_script=
, requested_dir);
> +
> +	switch ((pid =3D fork())) {
> +		case -1:
> +			logerror("path filter script fork() failed: %s", strerror(errno))=
;
> +			return NULL;
> +		case 0:
> +		close(pipe_out[0]);
> +		dup2(pipe_out[1], 1);
> +		close(pipe_out[1]);
> +
> +		execl(path_filter_script, path_filter_script, requested_dir, NULL)=
;

Use start_command()/finish_command() instead of rolling your own fork/e=
xec
combo.

-- Hannes
