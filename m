From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Bug in git status
Date: Wed, 26 Dec 2012 06:57:03 +0100
Message-ID: <50DA91AF.1060200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 07:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnk7K-00078x-I9
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 07:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040Ab2LZF5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 00:57:09 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:63887 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759Ab2LZF5I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Dec 2012 00:57:08 -0500
X-AuditID: 1207440f-b7f276d0000008b2-1a-50da91b36475
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C0.1A.02226.3B19AD05; Wed, 26 Dec 2012 00:57:07 -0500 (EST)
Received: from [192.168.69.140] (p57A256D8.dip.t-dialin.net [87.162.86.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBQ5v5xL014120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 26 Dec 2012 00:57:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLt54q0Agx87lC26rnQzOTB6fN4k
	F8AYxW2TlFhSFpyZnqdvl8CdcXTSCeaCr+wV6y8uZW9g3MjWxcjBISFgInHmUHQXIyeQKSZx
	4d56oDAXh5DAZUaJaav+s0M4z5gklj5qZQOp4hXQlmhbv5QRxGYRUJU4v3ADK4jNJqArsain
	mQnEFhUIkFi85Bw7RL2gxMmZT1hAbBGgml3ProLNERaQkrj/5D1YL7OAjsS7vgfMELa8xPa3
	c5gnMPLOQtI+C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKE
	BBP/Dsau9TKHGAU4GJV4eDd9vxkgxJpYVlyZe4hRkoNJSZT3Tc+tACG+pPyUyozE4oz4otKc
	1OJDjBIczEoivM4fgcp5UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	7BOAhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiy+GBhjICkeoL0mIO28xQWJ
	uUBRiNZTjLoctxpuPmUUYsnLz0uVEufVBikSACnKKM2DWwFLHa8YxYE+FuZ93A9UxQNMO3CT
	XgEtYQJaEst3A2RJSSJCSqqBMcN6VfDEvQWlvyz/fVg3VX1GSEPblb3TvTrME1x8qi5HbN6k
	H3dqMcOeZt66xpC+vB3+WmVr2WsX5HXExR1/9CDQeFFnSETQ1sjMOJmHUz7anHksWzrZ9lf+
	CRHGf+f//8wuW684S/q75pXnD/Yf5mx8Zvj02sudn96te10rNk/nUeQ9V5Ol2kos 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212127>

I think I have found a bug in "git status --untracked-files=all
--ignored", in both 1.8.0 and in master:

$ git init status-test
Initialized empty Git repository in
/home/mhagger/self/proj/git/status-test/.git/
$ cd status-test
$ touch x
$ touch x.ignore-me
$ mkdir y
$ touch y/foo
$ touch y/foo.ignore-me
$ git status --porcelain --untracked-files=all --ignored
?? x
?? x.ignore-me
?? y/foo
?? y/foo.ignore-me

The above output is what I expect.  But if I add a .gitignore file, the
output of y/foo.ignore-me is incorrectly suppressed:

$ echo '*.ignore-me' >.gitignore
$ git status --porcelain --untracked-files=all --ignored
?? .gitignore
?? x
?? y/foo
!! x.ignore-me

I came across this problem when trying to use the results of the above
command to build a more flexible "git clean" type of script.

I don't have time to look into this at the moment, if somebody wants to
jump in.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
