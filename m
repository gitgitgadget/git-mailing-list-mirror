From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] fsck_commit_buffer(): do not special case the last
 validation
Date: Fri, 15 Apr 2016 15:41:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604151538230.2967@virtualbox>
References: <20160414180709.28968-1-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 15:41:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar408-0003Cx-0j
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 15:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbcDONl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 09:41:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:49690 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbcDONlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 09:41:25 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MO7im-1anmCf39XA-005Wkk; Fri, 15 Apr 2016 15:41:17
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160414180709.28968-1-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:naUAHdxQ+GryYCZ6TVAbx57iNQQ5GPniDar7bO9WeeUgiWcjgRt
 ZlgFTEFtY7ZlDZu0pcMwu8F8QdJwy2tA5IVRFwfmKISxmShTk9Y6qulrObqV2d0zjtmIvqI
 uXmUcU5HjNi6cNvvcsCt5N+MDbSIbTvkEOOzGNvhhsN3pNNWv2SyP+7n7EnAXOjmMvqRFe/
 5xN+BAcvVrPaFxuuFjUZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wlIkI4kpsPk=:ABe2J2oiB+qerej1Ze0vEL
 tvmvrLE4otKCBP8QNYQ1zbhjSVlnopwleeNChllIEeXOSGoNg27CiLm5DL22bZ2O5aKkE7ijv
 vD2a0WzUuffyfhfWHuIC7cFeoF4TNtds4jUeX6avKjvuf+nfbV1fJtCCalf9x45gs+P/t/1th
 Zl/SU/qMUjb3pfC6thUeV++sIpLlPKWXI5yUn2zYymgR+5wVMShnefZrE7QgguYVXufTHn6kb
 U6n+51Fe90eEWYBL0wVYcIc5WCwJY53xjmiCXMk6V0F4ljd/kouwdTCWPHH212eT9wBDp3irj
 m1F6ssPji4SuHsC1+is1wrTl51u6KzzsTci4O64I7XH7ODkxExJewldnnhWs2J+UW4vFiYH9U
 rkZx2NGqbiUCpK0W7Uz3v4nfW0eMl6QEjFr2DA+W/pHUHO+0tkroCR1n31M/5GxR9jTTfqn77
 UEpkem4JE/lL7HIfaQor0AARxxQ1Qs0WMaeiboQXQFDBQwOkypiADLhh7Ec+vK759QtBwXqh7
 JQb4pm9NFiiif7OL5DcvzMY4MvvvisUAuZ7ETebgukIob4EfC8yf1g3usy91rgZawrZkCUcsF
 0zQmLnn/PB13WhkhBQUv1SGU/DI2kve07IT3e7BjsgPFEI7y7XzqutV9Rt1lCApzmwpohHdKu
 dC+yhcbDzjzi5bqYMNb8h6lgO0H48C/VzCsUYNCxHBlmf/s83qkHfp4jyuAXFjbQly/3+K8pz
 ANyWvxUzBIi1sTp48JMc7HVjeKbExx7vsXd6mupnR0xnm5nioLwhcwslUg+QDdAJEC54XswZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291604>

Hi Junio,

On Thu, 14 Apr 2016, Junio C Hamano wrote:

> The pattern taken by all the validations in this function is:
> 
> 	if (notice a violation exists) {
> 		err = report(... VIOLATION_KIND ...);
> 		if (err)
> 			return err;
> 	}
> 
> where report() returns zero if specified kind of violation is set to
> be ignored, and otherwise shows an error message and returns non-zero.
> 
> The last validation in the function immediately after the function
> returns 0 to declare "all good" can cheat and directly return the
> return value from report(), and the current code does so, i.e.
> 
> 	if (notice a violation exists)
> 		return report(... VIOLATION_KIND ...);
> 	return 0;
> 
> But that is a selfish code that declares it is the ultimate and
> final form of the function, never to be enhanced later.  To allow
> and invite future enhancements, make the last test follow the same
> pattern.

FWIW I agree with this reasoning. Sorry for leaving this to you to clean
up.

Ciao,
Dscho
