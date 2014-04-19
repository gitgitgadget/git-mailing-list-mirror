From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/11] commit.c: use ref transactions for updates
Date: Sat, 19 Apr 2014 21:23:00 +0200
Message-ID: <5352CD14.4060808@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:23:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbaqz-0006XQ-Uw
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbaDSTXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:23:06 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52331 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095AbaDSTXD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 15:23:03 -0400
X-AuditID: 1207440d-f79d86d0000043db-d9-5352cd1687f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BB.D1.17371.61DC2535; Sat, 19 Apr 2014 15:23:02 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JJN0no019253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 15:23:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-8-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1BU7GxRssHkrl0XXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj09uZzAVrxCvmnGhhbWA8JtTFyMkhIWAicerC
	BCYIW0ziwr31bF2MXBxCApcZJfqOr2aCcM4xSWxefZoFpIpXQFvi15dfzCA2i4CqxNYrV8Bs
	NgFdiUU9zUANHByiAkESf84qQpQLSpyc+QSsVUTATmL9rYVg5cICrhKX1nQxgthCApUSzxav
	Ygdp5RRwllj70wjElBAQl+hpDAKpYBbQkXjX94AZwpaX2P52DvMERoFZSBbMQlI2C0nZAkbm
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghAcq7g/H/OplDjAIcjEo8vBsC
	AoOFWBPLiitzDzFKcjApifL+XR8ULMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd/0poBxvSmJl
	VWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYI38AxQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoSuOLgXEKkuIB2qsI0s5bXJCYCxSFaD3FqMtxoWFFC5MQS15+
	XqqUOK/uaaAiAZCijNI8uBWwdPSKURzoY2HeWJBRPMBUBjfpFdASJqAlf88EgCwpSURISTUw
	uhgxf2oI7nvmEcT46P4T7pvXnsl19mX/e5h7yyXi0jmeQy8XcFuXZbifzzY/kMC/6c+eN3FT
	HZ46nxQM2nNw2s/Zr649/XJkurtcSWernfQJs60LpI1YJuzY9brWfekclTJXf98X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246537>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Change commit.c to use ref transactions for all ref updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/commit.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d9550c5..b8e4389 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1541,11 +1541,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	const char *index_file, *reflog_msg;
>  	char *nl;
>  	unsigned char sha1[20];
> -	struct ref_lock *ref_lock;
>  	struct commit_list *parents = NULL, **pptr = &parents;
>  	struct stat statbuf;
>  	struct commit *current_head = NULL;
>  	struct commit_extra_header *extra = NULL;
> +	struct ref_transaction *transaction;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_commit_usage, builtin_commit_options);
> @@ -1667,12 +1667,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&author_ident);
>  	free_commit_extra_headers(extra);
>  
> -	ref_lock = lock_any_ref_for_update("HEAD",
> -					   !current_head
> -					   ? NULL
> -					   : current_head->object.sha1,
> -					   0, NULL);

The old version, above, contemplates that current_head might be NULL...

> -
>  	nl = strchr(sb.buf, '\n');
>  	if (nl)
>  		strbuf_setlen(&sb, nl + 1 - sb.buf);
> @@ -1681,14 +1675,22 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>  	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>  
> -	if (!ref_lock) {
> +	transaction = ref_transaction_begin();
> +	if (!transaction) {
>  		rollback_index_files();
> -		die(_("cannot lock HEAD ref"));
> +		die(_("HEAD: cannot start transaction"));
>  	}
> -	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
> +	if (ref_transaction_update(transaction, "HEAD", sha1,
> +				   current_head->object.sha1,
> +				   0, !!current_head)) {

...but here you dereference current_head without checking it first.

It upsets me that the test suite didn't catch this NULL pointer
dereference.  Either

1. current_head cannot in fact be NULL, in which case the commit message
should explain that fact and the code should be simplified

or

2. the test suite is incomplete.  If so, it would be great if you would
add a test that exercises this branch of the code (and catches your
error), and then fix the error.

>  		rollback_index_files();
>  		die(_("cannot update HEAD ref"));
>  	}
> +	if (ref_transaction_commit(transaction, sb.buf,
> +				   UPDATE_REFS_QUIET_ON_ERR)) {
> +		rollback_index_files();
> +		die(_("cannot commit HEAD ref"));
> +	}
>  
>  	unlink(git_path("CHERRY_PICK_HEAD"));
>  	unlink(git_path("REVERT_HEAD"));
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
