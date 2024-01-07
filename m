Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BC11702
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4T7SlZ1z3yz5tyS
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 21:02:18 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4T7SlP1xyGz5tl9;
	Sun,  7 Jan 2024 21:02:09 +0100 (CET)
Message-ID: <de9cf40a-1ad6-45fb-8b70-8b0c71a3bfbb@kdbg.org>
Date: Sun, 7 Jan 2024 21:02:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] mingw: give more details about unsafe directory's
 ownership
Content-Language: en-US
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Cc: sunshine@sunshineco.com, git@vger.kernel.org
References: <xmqqbka07te6.fsf@gitster.g>
 <20240106112917.1870-1-soekkle@freenet.de>
 <20240106112917.1870-2-soekkle@freenet.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240106112917.1870-2-soekkle@freenet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 06.01.24 um 12:29 schrieb Sören Krecker:
> Add domain/username in error message, if owner sid of repository and
> user sid are not equal on windows systems.
> 
> Old error message:
> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
> 	'S-1-5-21-571067702-4104414259-3379520149-500'
> but the current user is:
> 	'S-1-5-21-571067702-4104414259-3379520149-1001'
> To add an exception for this directory, call:
> 
> 	git config --global --add safe.directory C:/Users/test/source/repos/git
> '''
> 
> New error message:
> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
>         'DESKTOP-L78JVA6/Administrator' (S-1-5-21-571067702-4104414259-3379520149-500)
> but the current user is:
>         'DESKTOP-L78JVA6/test' (S-1-5-21-571067702-4104414259-3379520149-1001)
> To add an exception for this directory, call:
> 
>         git config --global --add safe.directory C:/Users/test/source/repos/git
> '''

I am not a fan of putting everything and the kitchen sink inside quotes.
In particular, the single-quotes around the user names are unnecessary,
IMO. Would you mind dropping them? (I do not mean to remove the quotes
around the path names because you do not touch this part of the code.)

> 
> Signed-off-by: Sören Krecker <soekkle@freenet.de>
> ---
>  compat/mingw.c | 64 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 42053c1f65..6240387205 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2684,6 +2684,26 @@ static PSID get_current_user_sid(void)
>  	return result;
>  }
>  
> +static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
> +{
> +	SID_NAME_USE pe_use;
> +	DWORD len_user = 0, len_domain = 0;
> +	BOOL translate_sid_to_user;
> +
> +	/* returns only FALSE, because the string pointers are NULL*/
> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
> +			  &pe_use); 
> +	/*Alloc needed space of the strings*/

This comment line doesn't follow our style. Please either fix that (add
blanks after /* and before */ or (my preference) remove it altogether;
the code is clear without it.

> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user); 
> +	translate_sid_to_user = LookupAccountSidA(NULL, sid, (*str) + len_domain, &len_user,
> +				   *str, &len_domain, &pe_use);
> +	if (translate_sid_to_user == FALSE)

We prefer to write this condition as

	if (!translate_sid_to_user)

> +		FREE_AND_NULL(*str);
> +	else
> +		(*str)[len_domain] = '/';
> +	return translate_sid_to_user;
> +}
> +
>  static int acls_supported(const char *path)
>  {
>  	size_t offset = offset_1st_component(path);
> @@ -2765,27 +2785,45 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
>  			strbuf_addf(report, "'%s' is on a file system that does "
>  				    "not record ownership\n", path);
>  		} else if (report) {
> -			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
> +			LPSTR str1, str2, str3, str4, to_free1 = NULL, to_free3 = NULL, to_local_free2=NULL, to_local_free4=NULL;

This line grew a bit long now. Maybe break it to have lines not exceed
80 characters? While you do so, please insert blanks around = signs.

>  
> -			if (ConvertSidToStringSidA(sid, &str1))
> +			if (user_sid_to_user_name(sid, &str1))
>  				to_free1 = str1;
>  			else
>  				str1 = "(inconvertible)";
> -
> -			if (!current_user_sid)
> -				str2 = "(none)";
> -			else if (!IsValidSid(current_user_sid))
> -				str2 = "(invalid)";
> -			else if (ConvertSidToStringSidA(current_user_sid, &str2))
> -				to_free2 = str2;
> +			if (ConvertSidToStringSidA(sid, &str2))
> +				to_local_free2 = str2;
>  			else
>  				str2 = "(inconvertible)";
> +
> +			if (!current_user_sid) {
> +				str3 = "(none)";
> +				str4 = "(none)";
> +			}
> +			else if (!IsValidSid(current_user_sid)) {
> +				str3 = "(invalid)";
> +				str4 = "(invalid)";
> +			} else {
> +				if (user_sid_to_user_name(current_user_sid,
> +							  &str3))
> +					to_free3 = str3;
> +				else
> +					str3 = "(inconvertible)";
> +				if (ConvertSidToStringSidA(current_user_sid,
> +							   &str4))
> +					to_local_free4 = str4;
> +				else
> +					str4 = "(inconvertible)";
> +			}
>  			strbuf_addf(report,
>  				    "'%s' is owned by:\n"
> -				    "\t'%s'\nbut the current user is:\n"
> -				    "\t'%s'\n", path, str1, str2);
> -			LocalFree(to_free1);
> -			LocalFree(to_free2);
> +				    "\t'%s' (%s)\nbut the current user is:\n"
> +				    "\t'%s' (%s)\n",
> +				    path, str1, str2, str3, str4);
> +			free(to_free1);
> +			LocalFree(to_local_free2);
> +			free(to_free3);
> +			LocalFree(to_local_free4);
>  		}
>  	}
>  

Aside from this, the patch works well for me. It is a real usability
improvement. Thank you for working on it.

-- Hannes

