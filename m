From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 05/17] mktree: read textual tree representation with
 strbuf_getline_crlf()
Date: Mon, 4 Jan 2016 13:27:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041316370.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:28:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Ew-0007hR-AA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbcADM1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:27:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:54895 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbcADM1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:27:46 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LpwZn-1ZmFK51Ys3-00ffIT; Mon, 04 Jan 2016 13:27:42
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-6-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PDZNg/Oe23Qz2vv8VrF5MVq0EI+zqdmaoTgh6IELqUlFa69jQwS
 YwEWJm5TgZuA7oovek9h9psTpGXd5GnHFXC4weHGvIHy3ARTc/uO5jp69jyqGSuGy6baIhr
 IdXXXJBEPoOLxsvmGdkEM4TfTgs6ka/uR0hp10IaU1Dr/IHqlZE2XW4NUMPZ4lRDT6ZdqH2
 bUyAPolJMMhko12xBrpbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MSrredKCRG8=:RR74UWDn0BCgH0C/Z0fNx2
 IRkdOJNtwQOdU4H/HNwpXDQ7PgvujD6RFGszaDmMByGS/6SQRdW2cIJV+dX73joeAFf9h9HRp
 RDI2GD3k0FqR/ajQTIA9e8TcUBR0UWKqsGdQ5fqL47ZVLOHMjxfEgN0NjhmXRA3qP4ND2OPnO
 TejOwSTDg2C4yaelZghUhDXFZhNk9JgqA8cTY+lg58UGJgFN2libommRXujSHYjvoPV5NfKzq
 Wb4QePkRUXt0iSEMZPgHBHnAbck1K7/SDpl0QxmWeI0mE/xNo+V8iWQC/jRc1Se725idSl2iW
 Lk45IMcxiM01x94UYT1pG0rd9T2I0kiY0popen+bZE7W9V52ma5NUqxYfjekas41zWn6gHcm0
 6DflObBZZwUsan7vdVlBV37AXdyddnOpQTo9KBAClkMHxDJSRigHoTtHPsfKttdcWXfmozmXX
 Ve7kz7a9y/6I7d81ZyhdTgC8nNAUkQu48n8l08BQw8TkEHToD9uPEEpTKa4zHLnLlnqvY5emz
 nmzGXDaKpEwZS9Bs+EHfi7hvUtv7yo5L6GGQE2gncmjKrWXKBkCpUcvjg7J43t1GxgBtQwhfX
 dUMCCyN7kcBozOgdervtRqOXdtUhW+w5ogayK5zhNTZzWV5l9M52f01VqWdPDtXQU2JGAB+ba
 nKVDHAbEj1rYmAvH3YNfVfb9H0UGgjojxgczT/KcI67wU6XXa4F3PSBL5R/bBhmi/99EI9OHy
 7yZme9O+rAbpVuhaHWpQezuEV/VLS71YjNGDClsTVJd7adNZBNNrZzVuxDURoEDrx9yU7aLm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283305>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index a964d6b..c6cafb6 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -157,7 +157,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
>  
>  	while (!got_eof) {
>  		while (1) {
> -			if (strbuf_getline(&sb, stdin, line_termination) == EOF) {
> +			if ((line_termination
> +			     ? strbuf_getline_crlf(&sb, stdin)
> +			     : strbuf_getline(&sb, stdin, '\0')) == EOF) {
>  				got_eof = 1;
>  				break;
>  			}

Here also, I would recommend to change the logic to talk about
nul_delimited instead of line_termination first, and only then introduce
the change to call two different strbuf_* functions.

Ciao,
Dscho
