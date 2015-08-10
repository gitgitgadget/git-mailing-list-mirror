From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 11/17] refs.c: simplify strbufs in reflog setup and writing
Date: Mon, 10 Aug 2015 12:34:05 +0200
Message-ID: <55C87E1D.6080705@alum.mit.edu>
References: <20150810092731.GA9027@sigill.intra.peff.net> <20150810093638.GK30981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 12:34:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOkPl-0000e6-60
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 12:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933121AbbHJKel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 06:34:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57444 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933033AbbHJKeN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 06:34:13 -0400
X-AuditID: 12074413-f79bd6d000007ac2-c6-55c87e1fc734
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id FD.58.31426.F1E78C55; Mon, 10 Aug 2015 06:34:07 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7AAY5j9022797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 06:34:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150810093638.GK30981@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqCtfdyLUYMViVYuuK91MFj9aepgd
	mDye9e5h9Pi8SS6AKYrbJimxpCw4Mz1P3y6BO+Nkwwymgpf8Ff/X/WJpYLzK08XIySEhYCLR
	/Og9I4QtJnHh3no2EFtI4DKjxJ3TAV2MXED2eSaJEw9XMoMkeAW0JTr3djKB2CwCqhJdsx6C
	2WwCuhKLepqBbA4OUYEgidcvcyHKBSVOznzCAmKLCBhJ3PjwDWy+sIC/xNne1awQuzIkut/e
	AYtzClhL7OrqBlvFLKAu8WfeJShbXmL72znMExj5ZyEZOwtJ2SwkZQsYmVcxyiXmlObq5iZm
	5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihISj8A7GXSflDjEKcDAq8fDO2Hw8VIg1say4MvcQ
	oyQHk5Ior3vViVAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryR1UA53pTEyqrUonyYlDQHi5I4
	r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE74caoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTU
	osTSkox4UDzGFwMjEiTFA7SXpxZkb3FBYi5QFKL1FKOilDjvCZC5AiCJjNI8uLGwJPOKURzo
	S2HeMyBVPMAEBdf9CmgwE9Bgu0CwwSWJCCmpBkbxn8uEru5oMPJ9GL2ub9azt6pmr41jDbmb
	J1a+WbZm7pOmzdeSJ4fXzj3HG9fL7PPJ4d7tWdFfNJ1MnYvrKjd1W++6+KLKWkDhfOvpwMuu
	ZY8D10k4GAqvmNP10XPB0VUHWTxe1B9/IvOP9317t6VryQ6Fl7In2GdPfn06UHlZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275606>

On 08/10/2015 11:36 AM, Jeff King wrote:
> Commit 1a83c24 (git_snpath(): retire and replace with
> strbuf_git_path(), 2014-11-30) taught log_ref_setup and
> log_ref_write_1 to take a strbuf parameter, rather than a
> bare string. It then makes an alias to the strbuf's "buf"
> field under the original name.
> 
> This made the original diff much shorter, but the resulting
> code is more complicated that it needs to be. Since we've
> aliased the pointer, we drop our reference to the strbuf to
> ensure we don't accidentally change it. But if we simply
> drop our alias and use "logfile.buf" directly, we do not
> have to worry about this aliasing. It's a larger diff, but
> the resulting code is simpler.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 06f95c4..3666132 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3150,46 +3150,42 @@ static int should_autocreate_reflog(const char *refname)
>   * should_autocreate_reflog returns non-zero.  Otherwise, create it
>   * regardless of the ref name.  Fill in *err and return -1 on failure.
>   */
> -static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
> +static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
>  {
> [...]
> @@ -3233,36 +3229,32 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
>  
>  static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>  			   const unsigned char *new_sha1, const char *msg,
> -			   struct strbuf *sb_log_file, int flags,
> +			   struct strbuf *log_file, int flags,
>  			   struct strbuf *err)
>  {
> [...]

Nice change.

How about taking this opportunity to name the parameters ("logfile" vs.
"log_file") consistently?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
