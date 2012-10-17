From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v5 1/3] completion: add new __gitcompadd helper
Date: Wed, 17 Oct 2012 19:28:08 +0200
Message-ID: <20121017172808.GD2156@goldbirke>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
 <1350229971-9343-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 19:28:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOXQ5-0007ly-2X
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 19:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464Ab2JQR2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 13:28:25 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:60925 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab2JQR2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 13:28:13 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MQrwA-1SuBFO18YQ-00UghN; Wed, 17 Oct 2012 19:28:08 +0200
Content-Disposition: inline
In-Reply-To: <1350229971-9343-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:ZgrQzl7anvYacjUTHZPnV7m/mn8LKZA1mAb57gz8pTb
 l9NAFVQ/QKHZrNVI53IWXeP33qNJL2LergsRAhMJZqp1aPYhPb
 jx6mft8kSW4GBfrP2E71tdCksUIDROViB0Eej5YiyUgRfyGaxb
 33z/HQyM7fNYXtZ3RGEnVPr4/3oQk31KvUSbUs4l+y4M1gf9W5
 T+T+Efta8RHM8WfxukrGk+OCk442R2RTCABB3Ci/7eKvhseaEx
 D6XZGM/9Cu7y8OmWGNar6TcMaAgOQRCmQiXlx+Tlex1xAin3uP
 G45bXRulszt0XeJpgXt99cfJ7LvfoGy3Wjtfd4JZ8UCfM6Ias2
 oRgs0uStqsB3AqfjQ3k4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207924>

On Sun, Oct 14, 2012 at 05:52:49PM +0200, Felipe Contreras wrote:
> The idea is to never touch the COMPREPLY variable directly.
> 
> This allows other completion systems override __gitcompadd, and do
> something different instead.
> 
> Also, this allows the simplifcation of the completino tests (separate
> patch).
> 
> There should be no functional changes.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 65 ++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d743e56..01325de 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -225,6 +225,11 @@ _get_comp_words_by_ref ()
>  fi
>  fi
>  
> +__gitcompadd ()
> +{
> +	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
> +}
> +
>  # Generates completion reply with compgen, appending a space to possible
>  # completion words, if necessary.
>  # It accepts 1 to 4 arguments:
> @@ -238,13 +243,11 @@ __gitcomp ()
>  
>  	case "$cur_" in
>  	--*=)
> -		COMPREPLY=()
> +		__gitcompadd
>  		;;
>  	*)
>  		local IFS=$'\n'
> -		COMPREPLY=($(compgen -P "${2-}" \
> -			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
> -			-- "$cur_"))
> +		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
>  		;;
>  	esac
>  }
> @@ -261,7 +264,7 @@ __gitcomp ()
>  __gitcomp_nl ()
>  {
>  	local IFS=$'\n'
> -	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
> +	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
>  }

I feel hesitant about this change.  One of the ways I'm exploring to
fix the issues with shell metacharacters and expansion in compgen is
to actually replace compgen.  We already iterate over all possible
completion words in __gitcomp_1(), so it doesn't make much of a
difference to do the filtering for the current word while we are at
it.  However, the way __gitcompadd() encapsulates COMPREPLY=($(compgen
...)), and tha basic idea of never touching COMPREPLY directly make
this basically impossible.

>  __git_heads ()
> @@ -486,7 +489,7 @@ __git_complete_remote_or_refspec ()
>  			case "$cmd" in
>  			push) no_complete_refspec=1 ;;
>  			fetch)
> -				COMPREPLY=()
> +				__gitcompadd
>  				return
>  				;;
>  			*) ;;
> @@ -502,7 +505,7 @@ __git_complete_remote_or_refspec ()
>  		return
>  	fi
>  	if [ $no_complete_refspec = 1 ]; then
> -		COMPREPLY=()
> +		__gitcompadd
>  		return
>  	fi
>  	[ "$remote" = "." ] && remote=
> @@ -776,7 +779,7 @@ _git_am ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd

These changes effectively run compgen in a subshell to generate an
empty completion reply.  While it doesn't really matter on Linux,
it'll add another half a tenth of a second delay in those cases on my
Windows machine.  At least it should be conditional, i.e. $(compgen
...) shouldn't be executed when there are no possible completion
words.

However, I think those COMPREPLY=() assignments are pointless anyway.
COMPREPLY is always empty when completion functions are invoked, so
there is no need to explicitly set it to an empty array when we don't
provide any words for completion.  Their only use is basically to
explicitly tell us humans that in those cases we don't offer any words
for completion.  But we don't do that consistently: there are several
places without offering words for completion and without COMPREPLY=(),
e.g. the '__git_has_doubledash && return' pattern.

Perhaps it would be time to get rid of these COMPREPLY=() assignments?

>  }
>  
>  _git_apply ()
> @@ -796,7 +799,7 @@ _git_apply ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_add ()
> @@ -811,7 +814,7 @@ _git_add ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_archive ()
> @@ -856,7 +859,7 @@ _git_bisect ()
>  		__gitcomp_nl "$(__git_refs)"
>  		;;
>  	*)
> -		COMPREPLY=()
> +		__gitcompadd
>  		;;
>  	esac
>  }
> @@ -965,7 +968,7 @@ _git_clean ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_clone ()
> @@ -989,7 +992,7 @@ _git_clone ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_commit ()
> @@ -1023,7 +1026,7 @@ _git_commit ()
>  			"
>  		return
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_describe ()
> @@ -1154,7 +1157,7 @@ _git_fsck ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_gc ()
> @@ -1165,7 +1168,7 @@ _git_gc ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_gitk ()
> @@ -1242,7 +1245,7 @@ _git_init ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_ls_files ()
> @@ -1261,7 +1264,7 @@ _git_ls_files ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_ls_remote ()
> @@ -1377,7 +1380,7 @@ _git_mergetool ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_merge_base ()
> @@ -1393,7 +1396,7 @@ _git_mv ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_name_rev ()
> @@ -1563,7 +1566,7 @@ _git_send_email ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_stage ()
> @@ -1616,7 +1619,7 @@ _git_config ()
>  		local remote="${prev#remote.}"
>  		remote="${remote%.fetch}"
>  		if [ -z "$cur" ]; then
> -			COMPREPLY=("refs/heads/")
> +			__gitcompadd "refs/heads/"
>  			return
>  		fi
>  		__gitcomp_nl "$(__git_refs_remotes "$remote")"
> @@ -1676,7 +1679,7 @@ _git_config ()
>  		return
>  		;;
>  	*.*)
> -		COMPREPLY=()
> +		__gitcompadd
>  		return
>  		;;
>  	esac
> @@ -2056,7 +2059,7 @@ _git_remote ()
>  		__gitcomp "$c"
>  		;;
>  	*)
> -		COMPREPLY=()
> +		__gitcompadd
>  		;;
>  	esac
>  }
> @@ -2100,7 +2103,7 @@ _git_rm ()
>  		return
>  		;;
>  	esac
> -	COMPREPLY=()
> +	__gitcompadd
>  }
>  
>  _git_shortlog ()
> @@ -2170,7 +2173,7 @@ _git_stash ()
>  			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
>  				__gitcomp "$subcommands"
>  			else
> -				COMPREPLY=()
> +				__gitcompadd
>  			fi
>  			;;
>  		esac
> @@ -2183,14 +2186,14 @@ _git_stash ()
>  			__gitcomp "--index --quiet"
>  			;;
>  		show,--*|drop,--*|branch,--*)
> -			COMPREPLY=()
> +			__gitcompadd
>  			;;
>  		show,*|apply,*|drop,*|pop,*|branch,*)
>  			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
>  					| sed -n -e 's/:.*//p')"
>  			;;
>  		*)
> -			COMPREPLY=()
> +			__gitcompadd
>  			;;
>  		esac
>  	fi
> @@ -2307,7 +2310,7 @@ _git_svn ()
>  			__gitcomp "--revision= --parent"
>  			;;
>  		*)
> -			COMPREPLY=()
> +			__gitcompadd
>  			;;
>  		esac
>  	fi
> @@ -2332,13 +2335,13 @@ _git_tag ()
>  
>  	case "$prev" in
>  	-m|-F)
> -		COMPREPLY=()
> +		__gitcompadd
>  		;;
>  	-*|tag)
>  		if [ $f = 1 ]; then
>  			__gitcomp_nl "$(__git_tags)"
>  		else
> -			COMPREPLY=()
> +			__gitcompadd
>  		fi
>  		;;
>  	*)
> -- 
> 1.7.12.1
> 
